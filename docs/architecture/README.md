# Architecture Documentation

Comprehensive documentation of the Dofus Tools system architecture, design patterns, and technical decisions made during the migration.

## Overview

The Dofus Tools system is undergoing migration to a modern, scalable architecture:

```
┌─────────────────────────────────────────────────────────────┐
│                     Client Layer                            │
│              Angular 20 Single Page Application             │
└──────────────────────┬──────────────────────────────────────┘
                       │ REST API / WebSocket
┌──────────────────────▼──────────────────────────────────────┐
│                  API Layer                                   │
│         Spring Boot 3.x REST API (Java 26)                  │
├─────────────────────────────────────────────────────────────┤
│  Controllers  │  Services  │  Repositories  │  Security     │
└──────────────────────┬──────────────────────────────────────┘
                       │ JDBC / JPA
┌──────────────────────▼──────────────────────────────────────┐
│               Database Layer                                │
│             PostgreSQL Database                            │
└─────────────────────────────────────────────────────────────┘
```

## Technology Stack

### Backend
- **Runtime**: Java 26
- **Framework**: Spring Boot 3.x
- **Build Tool**: Maven or Gradle
- **Database**: PostgreSQL
- **Authentication**: JWT with Spring Security
- **Testing**: JUnit 5, Mockito

### Frontend
- **Framework**: Angular 20
- **Language**: TypeScript
- **Styling**: CSS/SCSS
- **Build Tool**: npm/Angular CLI
- **State Management**: RxJS Observables
- **Testing**: Jasmine, Karma

### Infrastructure
- **Containerization**: Docker
- **Orchestration**: Kubernetes (production)
- **CI/CD**: GitHub Actions
- **Monitoring**: TBD

## System Components

### Backend Components

#### Authentication & Authorization
- JWT-based authentication
- Role-based access control (RBAC)
- Spring Security integration

#### API Layer
- RESTful API endpoints
- Request/Response validation
- Error handling and logging

#### Business Logic
- Service layer for domain operations
- Business rule enforcement
- Transaction management

#### Data Access
- JPA/Hibernate for ORM
- Repository pattern implementation
- Database query optimization

### Frontend Components

#### Core Modules
- Authentication module
- Tool browsing module
- User management module
- Settings module

#### Shared Components
- Navigation component
- Footer component
- Error handling component
- Loading spinner

#### Services
- API service for backend communication
- Authentication service
- User service

## Design Patterns

### Backend Patterns

#### Repository Pattern
Abstracts data access logic and provides a cleaner interface for business logic.

```
Service → Repository → Database
```

#### Service Layer Pattern
Encapsulates business logic separate from controllers.

#### Dependency Injection
Spring's dependency injection for loose coupling and testability.

### Frontend Patterns

#### Component-Based Architecture
Angular components organized hierarchically.

#### Service-Based Communication
Centralized API communication through injectable services.

#### Observable Pattern (RxJS)
Reactive programming model for state and event handling.

## Database Schema

### Key Tables (Conceptual)

#### Users
```
┌─────────────────┐
│     Users       │
├─────────────────┤
│ id (PK)         │
│ email (UNIQUE)  │
│ username        │
│ password_hash   │
│ created_at      │
│ updated_at      │
└─────────────────┘
```

#### Tools
```
┌─────────────────┐
│     Tools       │
├─────────────────┤
│ id (PK)         │
│ name            │
│ description     │
│ category        │
│ version         │
│ created_at      │
│ updated_at      │
└─────────────────┘
```

#### User Tools (Saved/Favorites)
```
┌──────────────────┐
│   UserTools      │
├──────────────────┤
│ user_id (FK)     │
│ tool_id (FK)     │
│ saved_at         │
└──────────────────┘
```

## Security Architecture

### Authentication Flow

1. User submits credentials
2. Backend validates and generates JWT token
3. Frontend stores token (secure storage)
4. Subsequent requests include JWT in Authorization header
5. Backend validates token and identifies user

### Authorization
- Role-based access control (RBAC)
- Resource-level permissions
- API endpoint protection

### Data Security
- Password hashing (bcrypt/argon2)
- HTTPS/TLS for data in transit
- Database encryption at rest

## Deployment Architecture

### Development Environment
- Local Spring Boot server
- Local Angular dev server
- Docker containers for services

### Staging Environment
- Cloud-based deployment
- Staging database
- Full end-to-end testing

### Production Environment
- Kubernetes cluster
- Load balancing
- Database replication and backup

## Scalability Considerations

### Backend Scalability
- Horizontal scaling with load balancing
- Database connection pooling
- Caching layer (Redis) for frequently accessed data
- Async processing for long-running operations

### Frontend Scalability
- Code splitting and lazy loading
- Content delivery network (CDN)
- Browser caching strategies

## Monitoring & Observability

### Logging
- Centralized logging with ELK or similar
- Structured logging format
- Different log levels for different environments

### Metrics
- Application performance monitoring (APM)
- API response time tracking
- Error rate monitoring
- Resource utilization metrics

### Tracing
- Distributed tracing for request flows
- Correlation IDs for request tracking

## Migration Timeline

The migration is being executed in multiple waves:

- **Wave 0**: Documentation & Setup (Current)
- **Wave 1**: Backend Infrastructure & Core Services
- **Wave 2**: Frontend Migration & Component Development
- **Wave 3**: Integration & End-to-End Testing
- **Wave 4**: Performance & Security Hardening
- **Wave 5**: Deployment & Production Release

## Related Documentation

- [API Documentation](../api/README.md)
- [Deployment Guide](../deployment/README.md)
- [Developer Setup Guide](../guides/developer-setup.md)

---

**Document Status**: Template - To be completed during Wave 1
**Last Updated**: November 8, 2025
**Author**: Migration Team
