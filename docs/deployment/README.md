# Deployment Guide

Complete guide for deploying the Dofus Tools application to development, staging, and production environments.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Development Environment](#development-environment)
3. [Staging Environment](#staging-environment)
4. [Production Environment](#production-environment)
5. [Environment Configuration](#environment-configuration)
6. [Database Setup](#database-setup)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Tools

- **Java 26**: Backend runtime environment
- **Node.js 20+**: Frontend development and build
- **PostgreSQL 15+**: Database server
- **Docker**: For containerization
- **Docker Compose**: For multi-container management
- **Git**: Version control

### System Requirements

- **OS**: Linux, macOS, or Windows (WSL2)
- **RAM**: Minimum 8GB
- **Disk Space**: Minimum 20GB free space
- **Network**: Stable internet connection

## Development Environment

### Quick Start with Docker Compose

1. Clone the repository:
```bash
git clone https://github.com/N3ROO/dofus-tools.git
cd dofus-tools-fm-web
```

2. Copy environment template:
```bash
cp .env.example .env.local
```

3. Start services:
```bash
docker-compose up -d
```

4. Run database migrations:
```bash
docker-compose exec backend ./mvnw flyway:migrate
```

5. Start development servers:
```bash
# Terminal 1 - Backend
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"

# Terminal 2 - Frontend
cd frontend && npm start
```

### Local Development (Without Docker)

#### Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies and build
./mvnw clean install

# Run development server
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"
```

Backend will be available at: `http://localhost:8080`

#### Frontend Setup

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start development server
npm start
```

Frontend will be available at: `http://localhost:4200`

#### Database Setup

```bash
# PostgreSQL connection (development)
psql -U postgres -h localhost -p 5432

# Create development database
CREATE DATABASE dofus_tools_dev;
CREATE USER dofus_dev WITH PASSWORD 'dev_password';
GRANT ALL PRIVILEGES ON DATABASE dofus_tools_dev TO dofus_dev;
```

## Staging Environment

### Prerequisites

- Cloud provider account (AWS, Azure, GCP)
- Kubernetes cluster (optional for staging)
- Domain name configured
- SSL certificates

### Deployment Steps

1. Build Docker images:
```bash
docker build -t dofus-tools-backend:staging -f backend/Dockerfile .
docker build -t dofus-tools-frontend:staging -f frontend/Dockerfile .
```

2. Push to registry:
```bash
docker push registry.example.com/dofus-tools-backend:staging
docker push registry.example.com/dofus-tools-frontend:staging
```

3. Deploy to staging environment:
```bash
# Using Docker Compose
docker-compose -f docker-compose.staging.yml up -d

# Or using Kubernetes
kubectl apply -f k8s/staging/
```

4. Run database migrations:
```bash
docker exec dofus-tools-backend ./mvnw flyway:migrate -Dspring.profiles.active=staging
```

5. Verify deployment:
```bash
curl https://staging.dofus-tools.com/api/v1/health
```

### Staging Environment Variables

Create `.env.staging`:
```env
ENVIRONMENT=staging
DATABASE_URL=postgresql://user:password@staging-db:5432/dofus_tools_staging
JWT_SECRET=staging_jwt_secret_key
LOG_LEVEL=DEBUG
API_BASE_URL=https://staging-api.dofus-tools.com
```

## Production Environment

### Prerequisites

- Production-grade Kubernetes cluster
- Database replication setup
- Load balancer configuration
- CDN setup (optional)
- Monitoring and alerting

### Deployment Steps

1. Build production images:
```bash
docker build -t dofus-tools-backend:1.0.0 -f backend/Dockerfile --build-arg ENV=prod .
docker build -t dofus-tools-frontend:1.0.0 -f frontend/Dockerfile --build-arg ENV=prod .
```

2. Tag and push images:
```bash
docker tag dofus-tools-backend:1.0.0 registry.example.com/dofus-tools-backend:1.0.0
docker push registry.example.com/dofus-tools-backend:1.0.0
```

3. Deploy with Kubernetes:
```bash
kubectl apply -f k8s/production/
kubectl rollout status deployment/dofus-tools-backend
kubectl rollout status deployment/dofus-tools-frontend
```

4. Run database migrations:
```bash
kubectl exec -it deployment/dofus-tools-backend -- ./mvnw flyway:migrate
```

5. Verify health checks:
```bash
curl https://dofus-tools.com/api/v1/health
```

### Production Environment Variables

Create `.env.production`:
```env
ENVIRONMENT=production
DATABASE_URL=postgresql://user:password@prod-db-primary:5432/dofus_tools
DATABASE_REPLICA_URL=postgresql://user:password@prod-db-replica:5432/dofus_tools
JWT_SECRET=<strong_production_secret>
LOG_LEVEL=INFO
API_BASE_URL=https://api.dofus-tools.com
ENABLE_MONITORING=true
SENTRY_DSN=https://...@sentry.io/...
```

## Environment Configuration

### Configuration Files

```
config/
├── application.yml              # Base configuration
├── application-dev.yml          # Development profile
├── application-staging.yml      # Staging profile
└── application-prod.yml         # Production profile
```

### Common Environment Variables

| Variable | Development | Staging | Production |
|----------|-------------|---------|------------|
| ENVIRONMENT | dev | staging | prod |
| DEBUG | true | false | false |
| LOG_LEVEL | DEBUG | INFO | WARN |
| DATABASE_POOL_SIZE | 5 | 10 | 20 |
| CACHE_ENABLED | false | true | true |

## Database Setup

### Initial Setup

1. Create database:
```bash
createdb -U postgres dofus_tools
```

2. Run schema migrations:
```bash
./mvnw flyway:migrate -Dspring.profiles.active=<environment>
```

3. Load sample data (optional):
```bash
psql -U postgres dofus_tools < scripts/sample-data.sql
```

### Backup & Restore

```bash
# Backup
pg_dump -U postgres dofus_tools > backup.sql

# Restore
psql -U postgres dofus_tools < backup.sql
```

## Troubleshooting

### Backend Issues

#### Port 8080 Already in Use
```bash
# Find process using port
lsof -i :8080

# Kill process
kill -9 <PID>
```

#### Database Connection Error
```bash
# Verify PostgreSQL is running
pg_isready -h localhost -p 5432

# Check credentials in application.yml
```

#### Build Failures
```bash
# Clean and rebuild
./mvnw clean install -DskipTests

# Check Java version
java -version  # Should be Java 26
```

### Frontend Issues

#### Port 4200 Already in Use
```bash
ng serve --port 4201
```

#### Module Not Found
```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

#### Build Errors
```bash
# Clear Angular cache
ng cache clean

# Rebuild
npm run build
```

### Docker Issues

#### Container Won't Start
```bash
# Check logs
docker logs <container_id>

# Rebuild image
docker-compose build --no-cache
```

#### Volume Permission Issues
```bash
# Fix permissions (Linux)
sudo chown -R $USER:$USER ./volumes/
```

## Monitoring & Logs

### Backend Logs
```bash
# Docker
docker logs dofus-tools-backend -f

# Kubernetes
kubectl logs -f deployment/dofus-tools-backend
```

### Frontend Logs
```bash
# Browser console logs
chrome://chrome://devtools
```

### Database Logs
```bash
# PostgreSQL logs
tail -f /var/log/postgresql/postgresql.log
```

## Rollback Procedures

### Docker Compose Rollback
```bash
docker-compose down
git checkout <previous_version>
docker-compose up -d
```

### Kubernetes Rollback
```bash
# View rollout history
kubectl rollout history deployment/dofus-tools-backend

# Rollback to previous version
kubectl rollout undo deployment/dofus-tools-backend

# Rollback to specific version
kubectl rollout undo deployment/dofus-tools-backend --to-revision=3
```

## Related Documentation

- [Architecture Documentation](../architecture/README.md)
- [Developer Setup Guide](../guides/developer-setup.md)
- [API Documentation](../api/README.md)

---

**Document Status**: Template - To be expanded during deployment setup
**Last Updated**: November 8, 2025
**Maintainer**: DevOps Team
