# Developer Setup Guide

Complete instructions for setting up your local development environment for the Dofus Tools project.

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Installation Steps](#installation-steps)
3. [Repository Setup](#repository-setup)
4. [Backend Setup](#backend-setup)
5. [Frontend Setup](#frontend-setup)
6. [Database Setup](#database-setup)
7. [Running the Application](#running-the-application)
8. [IDE Configuration](#ide-configuration)
9. [Development Workflow](#development-workflow)
10. [Common Issues](#common-issues)

## System Requirements

### Minimum Requirements

- **OS**: Windows (WSL2), macOS, or Linux
- **RAM**: 8GB
- **Disk Space**: 20GB free
- **Network**: Stable internet connection

### Required Software

| Tool | Version | Purpose |
|------|---------|---------|
| Git | 2.30+ | Version control |
| Java | 26+ | Backend runtime |
| Node.js | 20+ | Frontend tooling |
| npm | 10+ | Package manager |
| PostgreSQL | 15+ | Database |
| Docker | 20.10+ | Containerization |

## Installation Steps

### Windows (WSL2)

1. **Enable WSL2**:
   - Open PowerShell as Administrator
   - Run: `wsl --install`
   - Restart your computer

2. **Install Ubuntu in WSL2**:
   - Open Microsoft Store
   - Search and install "Ubuntu 22.04 LTS"
   - Launch Ubuntu and complete initial setup

3. **Install Required Tools** (in WSL2 terminal):
```bash
# Update package manager
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y build-essential curl wget git

# Install Java 26
sudo apt install -y openjdk-26-jdk

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install PostgreSQL
sudo apt install -y postgresql postgresql-contrib
```

### macOS

1. **Install Homebrew**:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **Install Required Tools**:
```bash
# Java 26
brew install openjdk@26
sudo ln -sfn /usr/local/opt/openjdk@26/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-26.jdk

# Node.js
brew install node@20

# PostgreSQL
brew install postgresql

# Docker
brew install docker
```

### Linux (Ubuntu/Debian)

1. **Install Required Tools**:
```bash
sudo apt update && sudo apt upgrade -y

# Java 26
sudo apt install -y openjdk-26-jdk

# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Repository Setup

### 1. Clone Repository

```bash
git clone https://github.com/N3ROO/dofus-tools.git
cd dofus-tools-fm-web
```

### 2. Create Development Branch

```bash
# Update main branch
git fetch origin
git checkout main
git pull origin main

# Create your development branch
git checkout -b feature/your-feature-name
```

### 3. Configure Git

```bash
# Set your identity
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Configure line endings
git config core.autocrlf true  # Windows
git config core.autocrlf input # macOS/Linux
```

## Backend Setup

### 1. Install Maven (Optional)

The project includes Maven wrapper (`mvnw`), so Maven installation is optional:

```bash
# If you prefer to install Maven separately
# macOS
brew install maven

# Ubuntu/Debian
sudo apt install -y maven

# Windows (Chocolatey)
choco install maven
```

### 2. Build Backend

```bash
cd backend

# Download dependencies and compile
./mvnw clean install

# Or with Maven installed globally
mvn clean install
```

### 3. Verify Build

```bash
# Check successful compilation
./mvnw -version
java -version  # Verify Java 26
```

## Frontend Setup

### 1. Install Angular CLI

```bash
npm install -g @angular/cli@20

# Verify installation
ng version
```

### 2. Install Dependencies

```bash
cd frontend

# Install npm dependencies
npm install

# Install peer dependencies if needed
npm install
```

### 3. Verify Installation

```bash
ng version
npm -v  # Verify npm version
```

## Database Setup

### 1. Start PostgreSQL

**Linux**:
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql  # Enable on startup
```

**macOS**:
```bash
brew services start postgresql
```

**Windows (WSL2)**:
```bash
sudo service postgresql start
```

### 2. Create Development Database

```bash
# Connect to PostgreSQL
sudo -u postgres psql

# In PostgreSQL prompt:
CREATE DATABASE dofus_tools_dev;
CREATE USER dofus_dev WITH PASSWORD 'dev_password';
ALTER USER dofus_dev WITH CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE dofus_tools_dev TO dofus_dev;
\q
```

### 3. Run Migrations

```bash
cd backend

# Run Flyway migrations
./mvnw flyway:migrate -Dspring.profiles.active=dev

# Verify database
psql -U dofus_dev -d dofus_tools_dev -c "\dt"
```

### 4. Configure Database Connection

Create `backend/src/main/resources/application-dev.yml`:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/dofus_tools_dev
    username: dofus_dev
    password: dev_password
    driver-class-name: org.postgresql.Driver
  jpa:
    hibernate:
      ddl-auto: validate
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
```

## Running the Application

### Option 1: Run Separately (Recommended for Development)

**Terminal 1 - Backend**:
```bash
cd backend
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"
```

Backend will be available at: `http://localhost:8080`

**Terminal 2 - Frontend**:
```bash
cd frontend
npm start
```

Frontend will be available at: `http://localhost:4200`

### Option 2: Run with Docker Compose

```bash
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Option 3: IDE Integration

See [IDE Configuration](#ide-configuration) section below.

## IDE Configuration

### IntelliJ IDEA

1. **Open Project**:
   - File → Open → Select project root
   - Choose to open as Maven project

2. **Configure SDK**:
   - File → Project Structure → Project
   - Select Java 26 SDK (or download it)

3. **Run Configurations**:
   - Edit Configurations
   - Add Spring Boot configuration for backend
   - Set Active profiles to "dev"

4. **Enable Annotation Processing**:
   - Settings → Compiler → Annotation Processors
   - Check "Enable annotation processing"

### Visual Studio Code

1. **Install Extensions**:
   - Extension Pack for Java
   - Spring Boot Extension Pack
   - Angular Language Service
   - Prettier - Code Formatter

2. **Configure Workspace** (`.vscode/settings.json`):
```json
{
  "java.home": "/usr/lib/jvm/java-26-openjdk",
  "java.configuration.updateBuildConfiguration": "automatic",
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
```

3. **Debug Configuration** (`.vscode/launch.json`):
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Spring Boot App",
      "request": "launch",
      "mainClass": "com.dofus.tools.DofusToolsApplication",
      "args": "--spring.profiles.active=dev"
    }
  ]
}
```

## Development Workflow

### Daily Workflow

1. **Start Development Session**:
```bash
# Update main branch
git fetch origin
git rebase origin/main

# Start development servers
# Terminal 1
cd backend && ./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"

# Terminal 2
cd frontend && npm start
```

2. **Make Changes**:
   - Edit code in your IDE
   - Changes auto-reload in development
   - Backend: Check logs in Terminal 1
   - Frontend: Check browser console in Terminal 2

3. **Test Your Changes**:
```bash
# Backend tests
cd backend && ./mvnw test

# Frontend tests
cd frontend && npm test
```

4. **Commit Changes**:
```bash
git add <files>
git commit -m "feat: describe your changes"
git push origin feature/your-feature-name
```

### Pre-Commit Checks

Before committing, run:

```bash
# Backend
cd backend
./mvnw clean compile
./mvnw test
./mvnw checkstyle:check

# Frontend
cd frontend
npm run lint
npm run test
```

### Creating a Pull Request

1. Push your branch to GitHub
2. Go to repository → Pull requests
3. Click "New Pull Request"
4. Select your branch → main
5. Fill in description and create PR

## Common Issues

### Issue: Java 26 Not Found

**Solution**:
```bash
# Check installed Java
java -version

# Set JAVA_HOME
# macOS/Linux
export JAVA_HOME=$(/usr/libexec/java_home -v 26)

# Windows (PowerShell)
$env:JAVA_HOME="C:\Program Files\Java\jdk-26"

# Add to PATH
export PATH=$JAVA_HOME/bin:$PATH
```

### Issue: PostgreSQL Connection Refused

**Solution**:
```bash
# Check PostgreSQL status
pg_isready -h localhost -p 5432

# Restart PostgreSQL
sudo systemctl restart postgresql  # Linux
brew services restart postgresql   # macOS

# Check connection string
# Should be: jdbc:postgresql://localhost:5432/dofus_tools_dev
```

### Issue: npm install Fails

**Solution**:
```bash
# Clear npm cache
npm cache clean --force

# Remove node_modules and package-lock
rm -rf node_modules package-lock.json

# Reinstall
npm install

# Try with legacy peer deps if needed
npm install --legacy-peer-deps
```

### Issue: Port 8080 or 4200 Already in Use

**Solution**:
```bash
# Find process using port
# Linux/macOS
lsof -i :8080
lsof -i :4200

# Kill process
kill -9 <PID>

# Or run on different ports
# Backend
./mvnw spring-boot:run -Dserver.port=8081

# Frontend
ng serve --port 4201
```

### Issue: Build Fails with "Cannot find module"

**Solution**:
```bash
# Backend
cd backend
./mvnw clean install -U  # Force update dependencies

# Frontend
cd frontend
npm install
rm -rf .angular/cache
ng build
```

## Next Steps

1. Read the [Architecture Documentation](../architecture/README.md)
2. Check the [API Documentation](../api/README.md)
3. Review the [Deployment Guide](../deployment/README.md)
4. Start with issues marked "good first issue"

## Getting Help

- Check the [Common Issues](#common-issues) section above
- Review existing GitHub issues
- Ask in the project's discussion forum
- Contact the development team

---

**Document Status**: Complete
**Last Updated**: November 8, 2025
**Maintainer**: Development Team
