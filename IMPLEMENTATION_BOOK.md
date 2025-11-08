# Implementation Book: Multi-Agent Migration Strategy
## Dofus Tools Migration to Java 26 + Spring Boot 3.x + Angular 20

---

## Table of Contents
1. [Agent Profiles](#agent-profiles)
2. [Task Dependency Matrix](#task-dependency-matrix)
3. [Parallel Execution Waves](#parallel-execution-waves)
4. [Detailed Task Catalog](#detailed-task-catalog)
5. [Coordination Guidelines](#coordination-guidelines)
6. [Handoff Procedures](#handoff-procedures)

---

## 1. Agent Profiles

Each agent specializes in specific types of work. Tasks are assigned based on required expertise.

### Profile 1: BACKEND_SETUP
**Specialization**: Java project initialization, Maven/Gradle configuration, Spring Boot setup

**Capabilities**:
- Create and configure Java projects
- Setup Maven/Gradle build files
- Configure Spring Boot applications
- Setup application properties
- Database configuration

**Tools Required**: Java, Maven, Spring Boot

**Typical Tasks**: Project scaffolding, dependency management, configuration files

---

### Profile 2: BACKEND_DATA
**Specialization**: Database design, JPA entities, repositories, migrations

**Capabilities**:
- Design database schemas
- Create JPA entities with relationships
- Implement Spring Data repositories
- Write Flyway/Liquibase migrations
- Create database seed scripts

**Tools Required**: JPA, Hibernate, Flyway, SQL

**Typical Tasks**: Entity creation, repository implementation, database migrations

---

### Profile 3: BACKEND_LOGIC
**Specialization**: Business logic, service layer, algorithms

**Capabilities**:
- Implement business logic
- Create service classes
- Implement algorithms (calculations, string matching)
- Handle business rules
- Create utility classes

**Tools Required**: Java, Spring Framework

**Typical Tasks**: Service implementation, algorithm translation, utility classes

---

### Profile 4: BACKEND_API
**Specialization**: REST API design, controllers, DTOs, validation

**Capabilities**:
- Design REST endpoints
- Implement Spring MVC controllers
- Create DTOs and mappers
- Add validation annotations
- Setup OpenAPI documentation

**Tools Required**: Spring Web, Spring Validation, SpringDoc

**Typical Tasks**: Controller implementation, DTO creation, API documentation

---

### Profile 5: BACKEND_INTEGRATION
**Specialization**: External integrations, web scraping, file handling

**Capabilities**:
- Implement web scraping with Jsoup
- HTTP client integration
- File upload/download handling
- Image processing
- External API integration

**Tools Required**: Jsoup, Spring WebClient, File I/O

**Typical Tasks**: Web scraping implementation, file operations

---

### Profile 6: FRONTEND_SETUP
**Specialization**: Angular project initialization, configuration

**Capabilities**:
- Create Angular projects
- Configure Angular CLI
- Setup project structure
- Configure build tools
- Setup environments

**Tools Required**: Angular CLI, Node.js, npm

**Typical Tasks**: Project scaffolding, configuration, routing setup

---

### Profile 7: FRONTEND_COMPONENTS
**Specialization**: Angular components, templates, styling

**Capabilities**:
- Create Angular components
- Write HTML templates
- Implement component logic
- Apply CSS/SCSS styling
- Setup component communication

**Tools Required**: Angular, TypeScript, HTML, CSS/SCSS

**Typical Tasks**: Component creation, template design, styling

---

### Profile 8: FRONTEND_SERVICES
**Specialization**: Angular services, state management, HTTP clients

**Capabilities**:
- Create Angular services
- Implement HTTP clients
- Setup state management with RxJS
- Handle API integration
- Implement caching strategies

**Tools Required**: Angular, RxJS, TypeScript

**Typical Tasks**: Service implementation, API integration, state management

---

### Profile 9: TESTING_BACKEND
**Specialization**: Backend testing (unit, integration)

**Capabilities**:
- Write JUnit tests
- Create Mockito mocks
- Write integration tests
- Setup test fixtures
- Implement test utilities

**Tools Required**: JUnit 5, Mockito, Spring Test

**Typical Tasks**: Unit tests, integration tests, test coverage

---

### Profile 10: TESTING_FRONTEND
**Specialization**: Frontend testing (unit, E2E)

**Capabilities**:
- Write Jasmine/Karma tests
- Create component tests
- Write E2E tests with Playwright
- Setup test fixtures
- Mock HTTP requests

**Tools Required**: Jasmine, Karma, Playwright

**Typical Tasks**: Component tests, E2E tests, test coverage

---

### Profile 11: DEVOPS
**Specialization**: Docker, CI/CD, deployment

**Capabilities**:
- Create Dockerfiles
- Setup Docker Compose
- Configure CI/CD pipelines
- Deploy applications
- Setup monitoring

**Tools Required**: Docker, GitHub Actions, nginx

**Typical Tasks**: Containerization, CI/CD setup, deployment

---

### Profile 12: DOCUMENTATION
**Specialization**: Documentation, API specs, guides

**Capabilities**:
- Write technical documentation
- Create API documentation
- Write user guides
- Create deployment guides
- Document architecture

**Tools Required**: Markdown, OpenAPI

**Typical Tasks**: Documentation creation, guide writing

---

### Profile 13: REVIEWER
**Specialization**: Code review, quality assurance, wave validation

**Capabilities**:
- Review code quality and adherence to standards
- Verify task completion against acceptance criteria
- Check integration between components
- Validate architecture decisions
- Ensure consistency across codebase
- Verify testing coverage
- Check documentation completeness
- Identify technical debt and issues
- Validate security best practices
- Ensure performance considerations

**Tools Required**: All tools (read-only access), code analysis tools

**Typical Tasks**: Wave completion reviews, code quality checks, integration validation

**Review Checklist Per Wave**:
1. ✅ All tasks in wave completed
2. ✅ All acceptance criteria met
3. ✅ Code builds successfully
4. ✅ Tests pass (if applicable)
5. ✅ Code follows standards (naming, formatting)
6. ✅ No security vulnerabilities introduced
7. ✅ Documentation updated
8. ✅ Dependencies properly satisfied for next wave
9. ✅ No breaking changes without approval
10. ✅ Performance considerations addressed

**Review Report Format**:
```markdown
# Wave [X] Review Report

## Summary
- Status: ✅ APPROVED / ⚠️ APPROVED WITH NOTES / ❌ NEEDS REVISION
- Reviewed Tasks: [list]
- Issues Found: [count]
- Blockers for Next Wave: [yes/no]

## Detailed Findings

### Task: [TASK-ID]
- Status: ✅ / ⚠️ / ❌
- Issues: [list or "None"]
- Recommendations: [list or "None"]

## Overall Assessment
[Summary of wave quality]

## Recommendations for Next Wave
[Suggestions and improvements]

## Approval
- Approved for next wave: [yes/no]
- Required fixes before proceeding: [list or "None"]
```

---

## 2. Task Dependency Matrix

### Dependency Levels

- **L0**: No dependencies (can start immediately)
- **L1**: Depends on L0 tasks
- **L2**: Depends on L1 tasks
- **L3**: Depends on L2 tasks
- ... and so on

### Blocking vs Non-Blocking

- **BLOCKING**: Task must complete before dependent tasks can start
- **NON-BLOCKING**: Task can complete in parallel with dependent tasks
- **SOFT-BLOCKING**: Dependent tasks can start but may need updates

---

## 3. Parallel Execution Waves

### Wave 0: Foundation (L0 - No Dependencies)
**Can all run in parallel**

| Task ID | Task Name | Agent Profile | Duration |
|---------|-----------|---------------|----------|
| BE-SETUP-001 | Initialize Spring Boot Project | BACKEND_SETUP | 1h |
| FE-SETUP-001 | Initialize Angular Project | FRONTEND_SETUP | 1h |
| DOC-001 | Setup Documentation Structure | DOCUMENTATION | 30m |
| DEVOPS-001 | Create Git Branch Strategy | DEVOPS | 30m |

**Deliverables**: Project skeletons, basic structure
**Parallel Capacity**: 4 agents

---

### Wave 1: Core Configuration (L1 - Depends on Wave 0)
**Can all run in parallel after Wave 0**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| BE-SETUP-002 | Configure Maven Dependencies | BACKEND_SETUP | 1h | BE-SETUP-001 |
| BE-SETUP-003 | Configure Application Properties | BACKEND_SETUP | 1h | BE-SETUP-001 |
| BE-SETUP-004 | Setup Package Structure | BACKEND_SETUP | 30m | BE-SETUP-001 |
| BE-DATA-001 | Setup Database Configuration | BACKEND_DATA | 1h | BE-SETUP-001 |
| FE-SETUP-002 | Configure Angular Dependencies | FRONTEND_SETUP | 1h | FE-SETUP-001 |
| FE-SETUP-003 | Setup Project Structure | FRONTEND_SETUP | 1h | FE-SETUP-001 |
| FE-SETUP-004 | Configure Environments | FRONTEND_SETUP | 30m | FE-SETUP-001 |
| FE-SETUP-005 | Setup Angular Material | FRONTEND_SETUP | 1h | FE-SETUP-001 |

**Deliverables**: Configured projects ready for development
**Parallel Capacity**: 3-4 agents (can split BACKEND_SETUP and FRONTEND_SETUP work)

---

### Wave 2: Data Layer Foundation (L2)
**Can run in parallel after Wave 1**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| BE-DATA-002 | Create Rune Entity | BACKEND_DATA | 2h | BE-DATA-001 |
| BE-DATA-003 | Create RuneCategory Enum | BACKEND_DATA | 30m | BE-SETUP-004 |
| BE-DATA-004 | Create OperationType Enum | BACKEND_DATA | 30m | BE-SETUP-004 |
| BE-DATA-005 | Create Flyway Migration V1 | BACKEND_DATA | 2h | BE-DATA-001 |
| FE-SETUP-006 | Create Core Models (Interfaces) | FRONTEND_SERVICES | 1h | FE-SETUP-003 |
| FE-SETUP-007 | Setup HTTP Interceptors | FRONTEND_SERVICES | 1h | FE-SETUP-002 |
| FE-SETUP-008 | Configure Routing | FRONTEND_SETUP | 1h | FE-SETUP-003 |

**Deliverables**: Database schema, entity models, frontend models
**Parallel Capacity**: 2-3 agents (BACKEND_DATA can handle multiple tasks, FRONTEND can run separately)

---

### Wave 3: Repository & Base Services (L3)
**Split into backend and frontend sub-waves**

#### Wave 3A: Backend Repositories

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| BE-DATA-006 | Create RuneRepository | BACKEND_DATA | 1h | BE-DATA-002 |
| BE-DATA-007 | Create Database Seed Script | BACKEND_DATA | 2h | BE-DATA-005 |
| BE-DATA-008 | Copy Rune Images to Resources | BACKEND_INTEGRATION | 1h | BE-SETUP-004 |
| BE-LOGIC-001 | Create RuneWeightCalculator Utility | BACKEND_LOGIC | 3h | BE-DATA-003 |
| BE-LOGIC-002 | Create StringMatchingService | BACKEND_LOGIC | 4h | BE-SETUP-004 |

**Parallel Capacity**: 3 agents (BACKEND_DATA, BACKEND_INTEGRATION, BACKEND_LOGIC can work separately)

#### Wave 3B: Frontend Base Services

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| FE-SERVICE-001 | Create API Service (base HTTP) | FRONTEND_SERVICES | 2h | FE-SETUP-007 |
| FE-SERVICE-002 | Create RuneService | FRONTEND_SERVICES | 2h | FE-SERVICE-001, FE-SETUP-006 |
| FE-COMP-001 | Create NavbarComponent | FRONTEND_COMPONENTS | 2h | FE-SETUP-003 |
| FE-COMP-002 | Create LoadingSpinnerComponent | FRONTEND_COMPONENTS | 1h | FE-SETUP-003 |
| FE-ASSET-001 | Copy Rune Images to Assets | FRONTEND_SETUP | 1h | FE-SETUP-003 |

**Parallel Capacity**: 3 agents (FRONTEND_SERVICES for services, FRONTEND_COMPONENTS for UI, FRONTEND_SETUP for assets)

---

### Wave 4: Business Logic Services (L4)
**Backend-heavy wave**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| BE-LOGIC-003 | Create RuneService | BACKEND_LOGIC | 3h | BE-DATA-006 |
| BE-LOGIC-004 | Create CalculatorService | BACKEND_LOGIC | 4h | BE-LOGIC-003 |
| BE-LOGIC-005 | Create WebScrapingService | BACKEND_INTEGRATION | 4h | BE-LOGIC-001 |
| BE-API-001 | Create DTOs (Request) | BACKEND_API | 2h | BE-SETUP-004 |
| BE-API-002 | Create DTOs (Response) | BACKEND_API | 2h | BE-SETUP-004 |
| BE-API-003 | Create Exception Classes | BACKEND_API | 2h | BE-SETUP-004 |

**Deliverables**: Core business logic, DTOs
**Parallel Capacity**: 3 agents (BACKEND_LOGIC, BACKEND_INTEGRATION, BACKEND_API can work in parallel)

---

### Wave 5: REST Controllers (L5)
**Backend API layer**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| BE-API-004 | Create RuneController | BACKEND_API | 3h | BE-LOGIC-003, BE-API-001, BE-API-002 |
| BE-API-005 | Create CalculatorController | BACKEND_API | 3h | BE-LOGIC-004, BE-API-001, BE-API-002 |
| BE-API-006 | Create GlobalExceptionHandler | BACKEND_API | 2h | BE-API-003 |
| BE-API-007 | Add OpenAPI Annotations | BACKEND_API | 2h | BE-API-004, BE-API-005 |
| BE-API-008 | Configure CORS | BACKEND_SETUP | 1h | BE-SETUP-003 |

**Deliverables**: Complete REST API
**Parallel Capacity**: 2 agents (BACKEND_API can handle multiple controllers, BACKEND_SETUP for config)

---

### Wave 6: Frontend Services Layer (L6)
**Frontend services implementation**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| FE-SERVICE-003 | Create CalculatorService | FRONTEND_SERVICES | 3h | FE-SERVICE-001, BE-API-005 (API spec) |
| FE-SERVICE-004 | Create HistoryService | FRONTEND_SERVICES | 2h | FE-SETUP-006 |
| FE-SERVICE-005 | Update RuneService (full impl) | FRONTEND_SERVICES | 2h | FE-SERVICE-002, BE-API-004 (API spec) |

**Deliverables**: Frontend services with API integration
**Parallel Capacity**: 2 agents (can split services)

**Note**: SOFT-BLOCKING on Wave 5 - can start based on API spec from PRD, may need updates when actual API is ready

---

### Wave 7: Core Components (L7)
**Frontend components - Part 1**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| FE-COMP-003 | Create RuneAutocompleteComponent | FRONTEND_COMPONENTS | 4h | FE-SERVICE-005, FE-ASSET-001 |
| FE-COMP-004 | Create PuitCounterComponent | FRONTEND_COMPONENTS | 3h | FE-SETUP-006 |
| FE-COMP-005 | Create HistoryPanelComponent | FRONTEND_COMPONENTS | 3h | FE-SERVICE-004 |
| FE-COMP-006 | Create LandingComponent | FRONTEND_COMPONENTS | 2h | FE-COMP-001 |

**Deliverables**: Reusable components
**Parallel Capacity**: 2 agents (can split components)

---

### Wave 8: Main Feature Components (L8)
**Frontend components - Part 2**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| FE-COMP-007 | Create CalculatorSectionComponent | FRONTEND_COMPONENTS | 4h | FE-COMP-003 |
| FE-COMP-008 | Create ForgemagieComponent (main) | FRONTEND_COMPONENTS | 5h | FE-COMP-003, FE-COMP-004, FE-COMP-005, FE-SERVICE-003 |

**Deliverables**: Main calculator page
**Parallel Capacity**: 1 agent (FE-COMP-008 depends on FE-COMP-007)

---

### Wave 9: Styling & UX (L9)
**Can start once components exist**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| FE-STYLE-001 | Create SCSS Variables & Mixins | FRONTEND_COMPONENTS | 2h | FE-SETUP-003 |
| FE-STYLE-002 | Style NavbarComponent | FRONTEND_COMPONENTS | 1h | FE-COMP-001, FE-STYLE-001 |
| FE-STYLE-003 | Style LandingComponent | FRONTEND_COMPONENTS | 2h | FE-COMP-006, FE-STYLE-001 |
| FE-STYLE-004 | Style RuneAutocompleteComponent | FRONTEND_COMPONENTS | 2h | FE-COMP-003, FE-STYLE-001 |
| FE-STYLE-005 | Style PuitCounterComponent | FRONTEND_COMPONENTS | 2h | FE-COMP-004, FE-STYLE-001 |
| FE-STYLE-006 | Style HistoryPanelComponent | FRONTEND_COMPONENTS | 2h | FE-COMP-005, FE-STYLE-001 |
| FE-STYLE-007 | Style ForgemagieComponent | FRONTEND_COMPONENTS | 3h | FE-COMP-008, FE-STYLE-001 |
| FE-STYLE-008 | Implement Responsive Design | FRONTEND_COMPONENTS | 3h | All FE-STYLE-* |
| FE-STYLE-009 | Add Accessibility (ARIA) | FRONTEND_COMPONENTS | 2h | All FE-STYLE-* |

**Deliverables**: Fully styled application
**Parallel Capacity**: 3 agents (can split styling across components)

---

### Wave 10: Backend Testing (L10)
**Can start once services/controllers exist**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| BE-TEST-001 | Test RuneWeightCalculator | TESTING_BACKEND | 2h | BE-LOGIC-001 |
| BE-TEST-002 | Test StringMatchingService | TESTING_BACKEND | 3h | BE-LOGIC-002 |
| BE-TEST-003 | Test RuneService | TESTING_BACKEND | 3h | BE-LOGIC-003 |
| BE-TEST-004 | Test CalculatorService | TESTING_BACKEND | 4h | BE-LOGIC-004 |
| BE-TEST-005 | Test WebScrapingService | TESTING_BACKEND | 3h | BE-LOGIC-005 |
| BE-TEST-006 | Integration Test RuneController | TESTING_BACKEND | 3h | BE-API-004 |
| BE-TEST-007 | Integration Test CalculatorController | TESTING_BACKEND | 3h | BE-API-005 |
| BE-TEST-008 | Test Repository Layer | TESTING_BACKEND | 2h | BE-DATA-006 |

**Deliverables**: Backend test coverage (80%+)
**Parallel Capacity**: 3 agents (can split tests by layer)

---

### Wave 11: Frontend Testing (L11)
**Can start once components/services exist**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| FE-TEST-001 | Test RuneService | TESTING_FRONTEND | 2h | FE-SERVICE-005 |
| FE-TEST-002 | Test CalculatorService | TESTING_FRONTEND | 2h | FE-SERVICE-003 |
| FE-TEST-003 | Test HistoryService | TESTING_FRONTEND | 2h | FE-SERVICE-004 |
| FE-TEST-004 | Test RuneAutocompleteComponent | TESTING_FRONTEND | 3h | FE-COMP-003 |
| FE-TEST-005 | Test PuitCounterComponent | TESTING_FRONTEND | 2h | FE-COMP-004 |
| FE-TEST-006 | Test HistoryPanelComponent | TESTING_FRONTEND | 2h | FE-COMP-005 |
| FE-TEST-007 | Test ForgemagieComponent | TESTING_FRONTEND | 3h | FE-COMP-008 |
| FE-TEST-008 | E2E Test: Calculate PUIT Flow | TESTING_FRONTEND | 3h | FE-COMP-008 |
| FE-TEST-009 | E2E Test: Subtract Rune Flow | TESTING_FRONTEND | 2h | FE-COMP-008 |
| FE-TEST-010 | E2E Test: Calculate Rune Count Flow | TESTING_FRONTEND | 2h | FE-COMP-008 |

**Deliverables**: Frontend test coverage (70%+)
**Parallel Capacity**: 3 agents (can split unit tests and E2E tests)

---

### Wave 12: DevOps & Deployment (L12)
**Can start once application is functional**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| DEVOPS-002 | Create Backend Dockerfile | DEVOPS | 2h | BE-API-005 |
| DEVOPS-003 | Create Frontend Dockerfile | DEVOPS | 2h | FE-COMP-008 |
| DEVOPS-004 | Create Docker Compose | DEVOPS | 2h | DEVOPS-002, DEVOPS-003 |
| DEVOPS-005 | Create nginx.conf | DEVOPS | 1h | DEVOPS-003 |
| DEVOPS-006 | Setup PostgreSQL Config | DEVOPS | 1h | BE-DATA-001 |
| DEVOPS-007 | Create GitHub Actions CI | DEVOPS | 3h | BE-TEST-008, FE-TEST-010 |
| DEVOPS-008 | Create GitHub Actions CD | DEVOPS | 3h | DEVOPS-007 |
| DEVOPS-009 | Setup Environment Variables | DEVOPS | 1h | DEVOPS-004 |

**Deliverables**: Deployment infrastructure
**Parallel Capacity**: 2 agents (can split CI/CD and Docker work)

---

### Wave 13: Documentation (L13)
**Can run in parallel with many waves**

| Task ID | Task Name | Agent Profile | Duration | Dependencies |
|---------|-----------|---------------|----------|--------------|
| DOC-002 | Document API Endpoints | DOCUMENTATION | 3h | BE-API-007 |
| DOC-003 | Create Deployment Guide | DOCUMENTATION | 2h | DEVOPS-008 |
| DOC-004 | Create Developer Setup Guide | DOCUMENTATION | 2h | BE-SETUP-004, FE-SETUP-003 |
| DOC-005 | Create Architecture Documentation | DOCUMENTATION | 3h | BE-API-005, FE-COMP-008 |
| DOC-006 | Create User Guide (French) | DOCUMENTATION | 2h | FE-COMP-008 |
| DOC-007 | Update README.md | DOCUMENTATION | 1h | All tasks |

**Deliverables**: Complete documentation
**Parallel Capacity**: 2 agents (can split different doc types)

**Note**: DOC-002 to DOC-006 can start early based on PRD specs (SOFT-BLOCKING)

---

## 4. Detailed Task Catalog

### Format

Each task includes:
- **Task ID**: Unique identifier
- **Task Name**: Descriptive name
- **Agent Profile**: Required agent specialization
- **Duration**: Estimated time
- **Dependencies**: Tasks that must complete first
- **Blocking Type**: BLOCKING, NON-BLOCKING, or SOFT-BLOCKING
- **Can Run in Parallel With**: List of task IDs
- **Deliverables**: Expected outputs
- **Acceptance Criteria**: Definition of done
- **Implementation Notes**: Specific guidance

---

### BE-SETUP-001: Initialize Spring Boot Project

**Agent Profile**: BACKEND_SETUP

**Duration**: 1 hour

**Dependencies**: None (L0)

**Blocking Type**: BLOCKING (all backend work depends on this)

**Can Run in Parallel With**: FE-SETUP-001, DOC-001, DEVOPS-001

**Deliverables**:
- Spring Boot project structure
- `pom.xml` with parent Spring Boot dependency
- Main application class
- Basic package structure

**Acceptance Criteria**:
- ✅ Project builds successfully with `mvn clean install`
- ✅ Application starts without errors
- ✅ Health endpoint accessible at `/actuator/health`

**Implementation Notes**:
```bash
# Use Spring Initializr or:
mvn archetype:generate \
  -DgroupId=com.dofustools \
  -DartifactId=dofus-tools-api \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false

# Add Spring Boot parent in pom.xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.4.0</version>
</parent>
```

**Files to Create**:
- `/backend/pom.xml`
- `/backend/src/main/java/com/dofustools/DofusToolsApplication.java`
- `/backend/src/main/resources/application.yml`

---

### BE-SETUP-002: Configure Maven Dependencies

**Agent Profile**: BACKEND_SETUP

**Duration**: 1 hour

**Dependencies**: BE-SETUP-001

**Blocking Type**: BLOCKING (needed for all backend development)

**Can Run in Parallel With**: BE-SETUP-003, BE-SETUP-004, FE-SETUP-* tasks

**Deliverables**:
- Complete `pom.xml` with all dependencies

**Acceptance Criteria**:
- ✅ All dependencies download successfully
- ✅ No version conflicts
- ✅ Project builds with `mvn clean package`

**Implementation Notes**:

Add these dependencies to `pom.xml`:

```xml
<dependencies>
    <!-- Spring Boot Starters -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>

    <!-- Database -->
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>postgresql</artifactId>
        <scope>runtime</scope>
    </dependency>

    <!-- Flyway -->
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-core</artifactId>
    </dependency>

    <!-- Jsoup for web scraping -->
    <dependency>
        <groupId>org.jsoup</groupId>
        <artifactId>jsoup</artifactId>
        <version>1.17.2</version>
    </dependency>

    <!-- SpringDoc OpenAPI -->
    <dependency>
        <groupId>org.springdoc</groupId>
        <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        <version>2.3.0</version>
    </dependency>

    <!-- Lombok (optional) -->
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <optional>true</optional>
    </dependency>

    <!-- Testing -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

---

### BE-SETUP-003: Configure Application Properties

**Agent Profile**: BACKEND_SETUP

**Duration**: 1 hour

**Dependencies**: BE-SETUP-001

**Blocking Type**: BLOCKING (needed for database and API configuration)

**Can Run in Parallel With**: BE-SETUP-002, BE-SETUP-004

**Deliverables**:
- `application.yml`
- `application-dev.yml`
- `application-prod.yml`

**Acceptance Criteria**:
- ✅ Application starts with dev profile
- ✅ Database connection configured
- ✅ CORS configured
- ✅ API context path set

**Implementation Notes**:

Create `/backend/src/main/resources/application.yml`:

```yaml
spring:
  application:
    name: dofus-tools-api
  profiles:
    active: ${SPRING_PROFILES_ACTIVE:dev}

server:
  port: ${PORT:8080}
  servlet:
    context-path: /api

logging:
  level:
    root: INFO
    com.dofustools: DEBUG
```

Create `/backend/src/main/resources/application-dev.yml`:

```yaml
spring:
  datasource:
    url: jdbc:h2:mem:dofustools
    username: sa
    password:
    driver-class-name: org.h2.Driver

  h2:
    console:
      enabled: true
      path: /h2-console

  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: true
    properties:
      hibernate:
        format_sql: true

  flyway:
    enabled: true
    baseline-on-migrate: true

cors:
  allowed-origins: http://localhost:4200
```

---

### BE-SETUP-004: Setup Package Structure

**Agent Profile**: BACKEND_SETUP

**Duration**: 30 minutes

**Dependencies**: BE-SETUP-001

**Blocking Type**: BLOCKING (all classes need proper packages)

**Can Run in Parallel With**: BE-SETUP-002, BE-SETUP-003

**Deliverables**:
- Complete package directory structure

**Acceptance Criteria**:
- ✅ All required packages exist
- ✅ Package naming follows conventions

**Implementation Notes**:

Create this structure:

```
src/main/java/com/dofustools/
├── DofusToolsApplication.java
├── config/
│   ├── CorsConfig.java
│   ├── WebConfig.java
│   └── OpenApiConfig.java
├── controller/
├── service/
├── repository/
├── model/
│   ├── entity/
│   ├── dto/
│   │   ├── request/
│   │   └── response/
│   └── enums/
├── exception/
└── util/
```

---

### BE-DATA-001: Setup Database Configuration

**Agent Profile**: BACKEND_DATA

**Duration**: 1 hour

**Dependencies**: BE-SETUP-001

**Blocking Type**: BLOCKING (needed for entities and migrations)

**Can Run in Parallel With**: BE-SETUP-002, BE-SETUP-003, BE-SETUP-004

**Deliverables**:
- Database configuration class
- Flyway setup
- Initial migration directory structure

**Acceptance Criteria**:
- ✅ Database connection successful
- ✅ Flyway migrations directory exists
- ✅ H2 console accessible (dev mode)

**Implementation Notes**:

Create directory:
```
src/main/resources/db/migration/
```

Database will auto-configure from application.yml

---

### BE-DATA-002: Create Rune Entity

**Agent Profile**: BACKEND_DATA

**Duration**: 2 hours

**Dependencies**: BE-DATA-001, BE-SETUP-004

**Blocking Type**: BLOCKING (needed for repository and services)

**Can Run in Parallel With**: BE-DATA-003, BE-DATA-004

**Deliverables**:
- `Rune.java` entity class

**Acceptance Criteria**:
- ✅ All fields properly annotated with JPA annotations
- ✅ Proper validation annotations
- ✅ equals() and hashCode() implemented
- ✅ toString() implemented

**Implementation Notes**:

Create `/backend/src/main/java/com/dofustools/model/entity/Rune.java`:

```java
package com.dofustools.model.entity;

import com.dofustools.model.enums.RuneCategory;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "runes")
@EntityListeners(AuditingEntityListener.class)
public class Rune {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Column(nullable = false, unique = true, length = 100)
    private String label;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private RuneCategory category;

    @NotBlank
    @Column(nullable = false, length = 255)
    private String iconPath;

    @NotNull
    @Positive
    @Column(nullable = false, precision = 5, scale = 2)
    private BigDecimal weight;

    @Column(length = 500)
    private String description;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    // Constructors
    public Rune() {}

    public Rune(String label, RuneCategory category, String iconPath, BigDecimal weight) {
        this.label = label;
        this.category = category;
        this.iconPath = iconPath;
        this.weight = weight;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }

    public RuneCategory getCategory() { return category; }
    public void setCategory(RuneCategory category) { this.category = category; }

    public String getIconPath() { return iconPath; }
    public void setIconPath(String iconPath) { this.iconPath = iconPath; }

    public BigDecimal getWeight() { return weight; }
    public void setWeight(BigDecimal weight) { this.weight = weight; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Rune rune = (Rune) o;
        return Objects.equals(id, rune.id) && Objects.equals(label, rune.label);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, label);
    }

    @Override
    public String toString() {
        return "Rune{" +
                "id=" + id +
                ", label='" + label + '\'' +
                ", category=" + category +
                ", weight=" + weight +
                '}';
    }
}
```

Don't forget to enable JPA Auditing in config:

```java
package com.dofustools.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@Configuration
@EnableJpaAuditing
public class JpaConfig {
}
```

---

### BE-DATA-003: Create RuneCategory Enum

**Agent Profile**: BACKEND_DATA

**Duration**: 30 minutes

**Dependencies**: BE-SETUP-004

**Blocking Type**: NON-BLOCKING (can be created independently)

**Can Run in Parallel With**: BE-DATA-002, BE-DATA-004

**Deliverables**:
- `RuneCategory.java` enum

**Acceptance Criteria**:
- ✅ All categories defined (SIMPLE, PA, RA)
- ✅ Display names implemented
- ✅ Helper methods if needed

**Implementation Notes**:

Create `/backend/src/main/java/com/dofustools/model/enums/RuneCategory.java`:

```java
package com.dofustools.model.enums;

public enum RuneCategory {
    SIMPLE("Runes de type simple"),
    PA("Runes de type Pa"),
    RA("Runes de type Ra");

    private final String displayName;

    RuneCategory(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static RuneCategory fromDisplayName(String displayName) {
        for (RuneCategory category : values()) {
            if (category.displayName.equals(displayName)) {
                return category;
            }
        }
        throw new IllegalArgumentException("Unknown category: " + displayName);
    }
}
```

---

### BE-DATA-004: Create OperationType Enum

**Agent Profile**: BACKEND_DATA

**Duration**: 30 minutes

**Dependencies**: BE-SETUP-004

**Blocking Type**: NON-BLOCKING

**Can Run in Parallel With**: BE-DATA-002, BE-DATA-003

**Deliverables**:
- `OperationType.java` enum

**Acceptance Criteria**:
- ✅ All operation types defined

**Implementation Notes**:

Create `/backend/src/main/java/com/dofustools/model/enums/OperationType.java`:

```java
package com.dofustools.model.enums;

public enum OperationType {
    CALCULATE_PUIT,
    SUBTRACT_RUNE,
    MANUAL_ADD,
    MANUAL_SUBTRACT,
    CALCULATE_RUNE_COUNT
}
```

---

### BE-DATA-005: Create Flyway Migration V1

**Agent Profile**: BACKEND_DATA

**Duration**: 2 hours

**Dependencies**: BE-DATA-001, BE-DATA-002

**Blocking Type**: BLOCKING (needed for database initialization)

**Can Run in Parallel With**: BE-DATA-006 (can prepare repository code)

**Deliverables**:
- `V1__initial_schema.sql`
- Seed data script (optional separate migration)

**Acceptance Criteria**:
- ✅ Migration runs successfully
- ✅ Tables created with correct schema
- ✅ Indexes created
- ✅ Application starts without errors

**Implementation Notes**:

Create `/backend/src/main/resources/db/migration/V1__initial_schema.sql`:

```sql
-- Create runes table
CREATE TABLE runes (
    id BIGSERIAL PRIMARY KEY,
    label VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    icon_path VARCHAR(255) NOT NULL,
    weight DECIMAL(5,2) NOT NULL,
    description VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_runes_label ON runes(label);
CREATE INDEX idx_runes_category ON runes(category);
CREATE INDEX idx_runes_weight ON runes(weight);

-- Optional: calculation_history table
CREATE TABLE calculation_history (
    id BIGSERIAL PRIMARY KEY,
    session_id VARCHAR(100) NOT NULL,
    operation_type VARCHAR(50) NOT NULL,
    rune_removed_id BIGINT REFERENCES runes(id),
    rune_added_id BIGINT REFERENCES runes(id),
    puit_before DECIMAL(10,2) NOT NULL,
    puit_after DECIMAL(10,2) NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_history_session ON calculation_history(session_id);
CREATE INDEX idx_history_timestamp ON calculation_history(timestamp);
```

---

### BE-DATA-006: Create RuneRepository

**Agent Profile**: BACKEND_DATA

**Duration**: 1 hour

**Dependencies**: BE-DATA-002

**Blocking Type**: BLOCKING (needed for services)

**Can Run in Parallel With**: BE-LOGIC-001, BE-LOGIC-002

**Deliverables**:
- `RuneRepository.java` interface

**Acceptance Criteria**:
- ✅ Extends JpaRepository
- ✅ Custom query methods defined
- ✅ Works with entity

**Implementation Notes**:

Create `/backend/src/main/java/com/dofustools/repository/RuneRepository.java`:

```java
package com.dofustools.repository;

import com.dofustools.model.entity.Rune;
import com.dofustools.model.enums.RuneCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RuneRepository extends JpaRepository<Rune, Long> {

    Optional<Rune> findByLabel(String label);

    List<Rune> findByCategory(RuneCategory category);

    @Query("SELECT r FROM Rune r WHERE LOWER(r.label) LIKE LOWER(CONCAT('%', :search, '%'))")
    List<Rune> searchByLabel(String search);

    boolean existsByLabel(String label);
}
```

---

### BE-DATA-007: Create Database Seed Script

**Agent Profile**: BACKEND_DATA

**Duration**: 2 hours

**Dependencies**: BE-DATA-005

**Blocking Type**: NON-BLOCKING (can develop other features while seeding data)

**Can Run in Parallel With**: Most backend tasks

**Deliverables**:
- `V2__seed_runes.sql` OR Java-based seeder

**Acceptance Criteria**:
- ✅ All 103 runes inserted
- ✅ Correct weights, categories, and icon paths
- ✅ Data matches current runes.js

**Implementation Notes**:

Option 1: SQL Migration - Create `/backend/src/main/resources/db/migration/V2__seed_runes.sql`:

```sql
INSERT INTO runes (label, category, icon_path, weight) VALUES
('Rune Age', 'SIMPLE', 'images/runes/Rune Age (1).png', 1),
('Rune Cha', 'SIMPLE', 'images/runes/Rune Cha (1).png', 1),
('Rune Cri', 'SIMPLE', 'images/runes/Rune Cri (10).png', 10),
-- ... (all 103 runes)
('Rune Vi', 'SIMPLE', 'images/runes/Rune Vi (1).png', 1);
```

Option 2: Java Service - Create a CommandLineRunner for development:

```java
@Component
@Profile("dev")
public class RuneDataSeeder implements CommandLineRunner {

    @Autowired
    private RuneRepository runeRepository;

    @Override
    public void run(String... args) {
        if (runeRepository.count() == 0) {
            // Load and insert runes
        }
    }
}
```

---

### BE-DATA-008: Copy Rune Images to Resources

**Agent Profile**: BACKEND_INTEGRATION

**Duration**: 1 hour

**Dependencies**: BE-SETUP-004

**Blocking Type**: NON-BLOCKING

**Can Run in Parallel With**: All other tasks

**Deliverables**:
- All 103 rune images in `/backend/src/main/resources/static/images/runes/`

**Acceptance Criteria**:
- ✅ All images copied
- ✅ Filenames match database paths
- ✅ Images accessible via static resources

**Implementation Notes**:

```bash
# Copy from current project
cp -r images/runes/ backend/src/main/resources/static/images/

# Verify count
ls -1 backend/src/main/resources/static/images/runes/ | wc -l
# Should output: 103
```

Configure static resources in application.yml:

```yaml
spring:
  web:
    resources:
      static-locations: classpath:/static/
```

---

### BE-LOGIC-001: Create RuneWeightCalculator Utility

**Agent Profile**: BACKEND_LOGIC

**Duration**: 3 hours

**Dependencies**: BE-DATA-003 (RuneCategory enum)

**Blocking Type**: BLOCKING (needed for web scraping and data generation)

**Can Run in Parallel With**: BE-LOGIC-002, BE-DATA-006

**Deliverables**:
- `RuneWeightCalculator.java` utility class

**Acceptance Criteria**:
- ✅ Calculates correct weight for all rune types
- ✅ Handles base weights correctly
- ✅ Applies multiplicators (Pa = x3, Ra = x10)
- ✅ Unit tests pass

**Implementation Notes**:

Create `/backend/src/main/java/com/dofustools/util/RuneWeightCalculator.java`:

```java
package com.dofustools.util;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class RuneWeightCalculator {

    private static final Map<BigDecimal, List<String>> WEIGHT_MAP = new HashMap<>();

    static {
        WEIGHT_MAP.put(new BigDecimal("1"),
            List.of("Fo", "Ine", "Cha", "Age", "Ini", "Vi"));
        WEIGHT_MAP.put(new BigDecimal("2"),
            List.of("Puit", "Ré Terre", "Ré Feu", "Ré Eau", "Ré Air",
                    "Ré Neutre", "Ré Pou", "Ré Cri", "Pi Per"));
        WEIGHT_MAP.put(new BigDecimal("2.5"),
            List.of("Pod"));
        WEIGHT_MAP.put(new BigDecimal("3"),
            List.of("Sa", "Prospe"));
        WEIGHT_MAP.put(new BigDecimal("4"),
            List.of("Tac", "Fui"));
        WEIGHT_MAP.put(new BigDecimal("5"),
            List.of("Do Terre", "Do Feu", "Do Eau", "Do Air",
                    "Do Neutre", "Do Pou", "Do Cri", "Pi"));
        WEIGHT_MAP.put(new BigDecimal("6"),
            List.of("Ré Per Terre", "Ré Per Feu", "Ré Per Eau",
                    "Ré Per Air", "Ré Per Neutre"));
        WEIGHT_MAP.put(new BigDecimal("7"),
            List.of("Ré Pa", "Ré Pme", "Ret Pa", "Ret Pme"));
        WEIGHT_MAP.put(new BigDecimal("10"),
            List.of("So", "Cri", "Do Ren"));
        WEIGHT_MAP.put(new BigDecimal("15"),
            List.of("Do Per Mé", "Do Per Di", "Do Per Ar",
                    "Do Per So", "Ré Per Mé", "Ré Per Di"));
        WEIGHT_MAP.put(new BigDecimal("20"),
            List.of("Do"));
        WEIGHT_MAP.put(new BigDecimal("30"),
            List.of("Invo"));
        WEIGHT_MAP.put(new BigDecimal("51"),
            List.of("Po"));
        WEIGHT_MAP.put(new BigDecimal("90"),
            List.of("Ga Pme"));
        WEIGHT_MAP.put(new BigDecimal("100"),
            List.of("Ga Pa"));
    }

    /**
     * Calculate weight for a rune name
     * Formula: base_weight * multiplicator
     *
     * @param runeName The name of the rune
     * @return The calculated weight
     */
    public BigDecimal calculateWeight(String runeName) {
        BigDecimal baseWeight = findBaseWeight(runeName);
        int multiplicator = getMultiplicator(runeName);
        return baseWeight.multiply(BigDecimal.valueOf(multiplicator));
    }

    /**
     * Find base weight by matching patterns in rune name
     * Uses longest match to handle cases like "Do Per So" vs "So"
     */
    private BigDecimal findBaseWeight(String runeName) {
        int maxLength = -1;
        BigDecimal weight = BigDecimal.ONE;

        for (Map.Entry<BigDecimal, List<String>> entry : WEIGHT_MAP.entrySet()) {
            for (String pattern : entry.getValue()) {
                if (runeName.contains(pattern) && pattern.length() > maxLength) {
                    weight = entry.getKey();
                    maxLength = pattern.length();
                }
            }
        }

        return weight;
    }

    /**
     * Get multiplicator based on rune prefix
     * - "Rune Pa": x3
     * - "Rune Ra": x10
     * - Default: x1
     */
    private int getMultiplicator(String runeName) {
        if (runeName.contains("Rune Pa")) {
            return 3;
        } else if (runeName.contains("Rune Ra")) {
            return 10;
        }
        return 1;
    }
}
```

**Test this with**:

```java
@Test
void testCalculateWeight() {
    RuneWeightCalculator calculator = new RuneWeightCalculator();

    assertEquals(new BigDecimal("1"), calculator.calculateWeight("Rune Age"));
    assertEquals(new BigDecimal("3"), calculator.calculateWeight("Rune Pa Age"));
    assertEquals(new BigDecimal("10"), calculator.calculateWeight("Rune Ra Age"));
    assertEquals(new BigDecimal("100"), calculator.calculateWeight("Rune Ga Pa"));
    assertEquals(new BigDecimal("2.5"), calculator.calculateWeight("Rune Pod"));
}
```

---

### BE-LOGIC-002: Create StringMatchingService

**Agent Profile**: BACKEND_LOGIC

**Duration**: 4 hours

**Dependencies**: BE-SETUP-004

**Blocking Type**: BLOCKING (needed for autocorrect API)

**Can Run in Parallel With**: BE-LOGIC-001, BE-DATA-006

**Deliverables**:
- `StringMatchingService.java`

**Acceptance Criteria**:
- ✅ Implements letter occurrence algorithm
- ✅ Autocorrect works identically to JavaScript version
- ✅ Handles edge cases (empty strings, special characters)
- ✅ Unit tests pass with same test cases as JS

**Implementation Notes**:

Create `/backend/src/main/java/com/dofustools/service/StringMatchingService.java`:

```java
package com.dofustools.service;

import com.dofustools.model.dto.response.RuneAutocorrectResponse;
import com.dofustools.model.entity.Rune;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StringMatchingService {

    /**
     * Autocorrect input string to closest rune label
     * Algorithm: Letter occurrence matching (same as JavaScript version)
     *
     * @param input User input
     * @param runes List of all runes
     * @param maxGap Maximum allowed character difference
     * @return Autocorrection result
     */
    public RuneAutocorrectResponse autocorrect(String input, List<Rune> runes, int maxGap) {
        if (input == null || input.isBlank()) {
            return new RuneAutocorrectResponse(input, false, 0);
        }

        int minGap = Integer.MAX_VALUE;
        String closestRune = input;

        for (Rune rune : runes) {
            int gap = compareStrings(
                refactorString(rune.getLabel()),
                refactorString(input)
            );

            if (gap < minGap) {
                minGap = gap;
                closestRune = rune.getLabel();
            }
        }

        boolean success = minGap <= maxGap;
        return new RuneAutocorrectResponse(
            success ? closestRune : input,
            success,
            minGap
        );
    }

    /**
     * Compare two strings by letter occurrence
     * Returns absolute difference sum
     *
     * Same algorithm as JavaScript:
     * function compareStrings(str1, str2) {
     *   var str1_occ = getLettersOcc(str1);
     *   var str2_occ = getLettersOcc(str2);
     *   diff = 0;
     *   for(var i=0 ; i < 26; i++){
     *     diff += Math.abs(str1_occ[i] - str2_occ[i]);
     *   }
     *   return diff;
     * }
     */
    private int compareStrings(String str1, String str2) {
        int[] occ1 = getLetterOccurrences(str1);
        int[] occ2 = getLetterOccurrences(str2);

        int diff = 0;
        for (int i = 0; i < 26; i++) {
            diff += Math.abs(occ1[i] - occ2[i]);
        }

        return diff;
    }

    /**
     * Get letter occurrence array (a-z)
     *
     * Same as JavaScript:
     * function getLettersOcc(str) {
     *   var occ = Array(26).fill(0);
     *   for(var i=0; i < str.length; i++){
     *     var char_code = str.charCodeAt(i) - 97;
     *     if(char_code < 0 || char_code > 26){
     *       console.log("[getLettersOcc/Warning] character " + str.charAt(i) + " is to recognized. It will be ignored");
     *     }else{
     *       occ[char_code] ++;
     *     }
     *   }
     *   return occ;
     * }
     */
    private int[] getLetterOccurrences(String str) {
        int[] occ = new int[26];

        for (char c : str.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                occ[c - 'a']++;
            }
            // Ignore non-alphabetic characters (already filtered by refactorString)
        }

        return occ;
    }

    /**
     * Refactor string for comparison
     * - Lowercase
     * - Remove spaces
     * - Remove "rune"
     * - Remove accents (é -> e)
     * - Keep only a-z
     *
     * Same as JavaScript:
     * function refactoStr(str){
     *   str = str.toLowerCase();
     *   str = str.replace(/\s+/g, '');
     *   str = str.replace("rune", "");
     *   str = str.replace(/é+/g, "e");
     *   str = str.replace(/[^a-z]/g, "")
     *   return str;
     * }
     */
    private String refactorString(String str) {
        return str.toLowerCase()
            .replaceAll("\\s+", "")           // Remove spaces
            .replace("rune", "")               // Remove "rune"
            .replace("é", "e")                 // Replace é with e
            .replaceAll("[^a-z]", "");        // Keep only a-z
    }
}
```

**Unit Test**:

```java
@Test
void testAutocorrect_ExactMatch() {
    // Setup
    List<Rune> runes = Arrays.asList(
        new Rune("Rune Age", RuneCategory.SIMPLE, "path", BigDecimal.ONE)
    );

    // Execute
    RuneAutocorrectResponse result = service.autocorrect("Rune Age", runes, 2);

    // Assert
    assertTrue(result.success());
    assertEquals("Rune Age", result.correctedValue());
    assertEquals(0, result.gap());
}

@Test
void testAutocorrect_CloseMatch() {
    List<Rune> runes = Arrays.asList(
        new Rune("Rune Age", RuneCategory.SIMPLE, "path", BigDecimal.ONE),
        new Rune("Rune Vi", RuneCategory.SIMPLE, "path", BigDecimal.ONE)
    );

    // "Rune Ag" should match "Rune Age" (1 character difference)
    RuneAutocorrectResponse result = service.autocorrect("Rune Ag", runes, 2);

    assertTrue(result.success());
    assertEquals("Rune Age", result.correctedValue());
    assertTrue(result.gap() <= 2);
}

@Test
void testAutocorrect_NoMatch() {
    List<Rune> runes = Arrays.asList(
        new Rune("Rune Age", RuneCategory.SIMPLE, "path", BigDecimal.ONE)
    );

    // "xyz" is too different
    RuneAutocorrectResponse result = service.autocorrect("xyz", runes, 2);

    assertFalse(result.success());
    assertEquals("xyz", result.correctedValue());
}
```

---

## [TRUNCATED FOR LENGTH - This is a template showing the format]

---

## 5. Coordination Guidelines

### Agent Communication Protocol

1. **Task Selection**: Agent picks from available tasks (all dependencies met)
2. **Status Updates**: Agent updates task status (IN_PROGRESS, BLOCKED, COMPLETED)
3. **Deliverable Handoff**: Agent commits code and updates task status
4. **Dependency Notification**: When task completes, notify dependent tasks
5. **Blocking Issues**: If blocked, update status and notify coordinator

### Parallel Execution Rules

1. **Check Dependencies**: Before starting, verify all dependencies are COMPLETED
2. **Lock Task**: Mark task as IN_PROGRESS to prevent duplicate work
3. **No Overwrites**: Never modify files owned by other agents' in-progress tasks
4. **Integration Points**: Coordinate at wave boundaries
5. **Testing**: Each agent tests their deliverables before marking complete

### Git Workflow

1. **Branch per Wave**: Create branch like `wave-0-foundation`
2. **Atomic Commits**: One commit per task completion
3. **Clear Messages**: Use task ID in commit message
4. **Pull Before Push**: Always pull latest before pushing
5. **Conflict Resolution**: Notify coordinator if conflicts arise

---

## 6. Handoff Procedures

### Wave Completion Checklist

Before moving to next wave:

- ✅ All tasks in wave marked COMPLETED
- ✅ All deliverables committed and pushed
- ✅ All tests passing
- ✅ Integration smoke test passed
- ✅ Documentation updated
- ✅ Next wave dependencies satisfied

### Critical Handoff Points

1. **Wave 0 → Wave 1**: Project structure must build successfully
2. **Wave 2 → Wave 3**: Database schema must be valid
3. **Wave 4 → Wave 5**: Services must have unit tests passing
4. **Wave 5 → Wave 6**: API contract must be documented
5. **Wave 7 → Wave 8**: Components must be individually tested
6. **Wave 10/11 → Wave 12**: Test coverage must meet thresholds

---

## Appendix A: Quick Reference - Task Summary

### Total Tasks: 150+
### Estimated Duration: 8-10 weeks with parallel execution
### Agent Profiles: 12
### Parallel Capacity: 2-4 agents per wave

### Tasks by Agent Profile:

| Profile | Task Count | Estimated Hours |
|---------|------------|-----------------|
| BACKEND_SETUP | 8 | 12h |
| BACKEND_DATA | 12 | 24h |
| BACKEND_LOGIC | 15 | 45h |
| BACKEND_API | 18 | 42h |
| BACKEND_INTEGRATION | 8 | 24h |
| FRONTEND_SETUP | 10 | 15h |
| FRONTEND_COMPONENTS | 25 | 75h |
| FRONTEND_SERVICES | 12 | 30h |
| TESTING_BACKEND | 20 | 50h |
| TESTING_FRONTEND | 15 | 38h |
| DEVOPS | 12 | 24h |
| DOCUMENTATION | 10 | 20h |

**Total**: ~400 hours
**With 4 agents in parallel**: ~100 hours (12-13 weeks)

---

## Appendix B: Task Status Tracking Template

### Task Status Board

| Task ID | Status | Agent | Started | Completed | Blocked On |
|---------|--------|-------|---------|-----------|------------|
| BE-SETUP-001 | ✅ DONE | Agent-1 | 2025-01-15 | 2025-01-15 | - |
| BE-SETUP-002 | 🔄 IN PROGRESS | Agent-2 | 2025-01-15 | - | - |
| FE-SETUP-001 | ⏸️ PENDING | - | - | - | - |
| BE-DATA-001 | 🚫 BLOCKED | - | - | - | BE-SETUP-001 |

### Status Legend:
- ⏸️ **PENDING**: Not started, waiting for dependencies
- 🔄 **IN PROGRESS**: Currently being worked on
- ✅ **DONE**: Completed and verified
- 🚫 **BLOCKED**: Cannot proceed due to dependency
- ⚠️ **REVIEW**: Needs review before completion

---

## Appendix C: Agent Launch Commands

### Example: Starting Multiple Agents in Parallel

**Wave 0 Launch (4 agents)**:
```bash
# Terminal 1
Task: "You are BACKEND_SETUP agent. Execute task BE-SETUP-001: Initialize Spring Boot Project"

# Terminal 2
Task: "You are FRONTEND_SETUP agent. Execute task FE-SETUP-001: Initialize Angular Project"

# Terminal 3
Task: "You are DOCUMENTATION agent. Execute task DOC-001: Setup Documentation Structure"

# Terminal 4
Task: "You are DEVOPS agent. Execute task DEVOPS-001: Create Git Branch Strategy"
```

---

**END OF IMPLEMENTATION BOOK**

**Version**: 1.0
**Last Updated**: 2025-11-08
**Status**: Ready for Multi-Agent Execution
