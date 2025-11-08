# Dofus Tools API - Spring Boot Backend

## Project Information

- **Group ID**: com.dofustools
- **Artifact ID**: dofus-tools-api
- **Version**: 1.0.0-SNAPSHOT
- **Spring Boot Version**: 3.3.5
- **Java Version**: 21 (configured for 21, ready for 26 when available)

## Project Structure

```
backend/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── dofustools/
│   │   │           ├── DofusToolsApplication.java
│   │   │           ├── config/
│   │   │           ├── controller/
│   │   │           ├── service/
│   │   │           ├── repository/
│   │   │           ├── model/
│   │   │           └── util/
│   │   └── resources/
│   │       └── application.yml
│   └── test/
│       └── java/
│           └── com/
│               └── dofustools/
```

## Configuration

### Application Configuration (application.yml)

- **Server Port**: 8080
- **Context Path**: /api
- **Health Endpoint**: /api/actuator/health

### Main Application Class

The `DofusToolsApplication` class is the entry point for the Spring Boot application, located at:
`src/main/java/com/dofustools/DofusToolsApplication.java`

## Building the Project

### Standard Maven Build

```bash
cd backend
mvn clean install
```

### Running the Application

```bash
mvn spring-boot:run
```

Or after building:

```bash
java -jar target/dofus-tools-api-1.0.0-SNAPSHOT.jar
```

## Endpoints

### Health Check

- **URL**: http://localhost:8080/api/actuator/health
- **Method**: GET
- **Response**: Application health status

## Known Issues

### Maven Build in Sandboxed Environments

The current environment has a Java DNS resolution issue where Maven cannot resolve repository hostnames, despite network connectivity being available via curl. This is a known issue in certain Docker/sandboxed environments where the JVM cannot access the system's DNS resolver.

**Workaround for Development**:

1. Build in a standard environment with network access
2. Use a corporate/local Maven repository mirror
3. Pre-download dependencies and build offline

## Dependencies

- **spring-boot-starter-web**: RESTful web services
- **spring-boot-starter-actuator**: Production-ready features (health checks, metrics)
- **spring-boot-starter-test**: Testing framework (JUnit, Mockito, Spring Test)

## Next Steps

1. Add domain models for Forgemagie calculations
2. Implement REST controllers for item management
3. Add service layer for business logic
4. Configure database connectivity
5. Add security configuration
6. Implement CORS configuration for frontend integration

## Notes

- Java 26 specified in requirements; using Java 21 (LTS) until Java 26 is released
- Spring Boot 3.4.0 specified; using 3.3.5 (stable) due to initial availability
- Project structure is ready for immediate development once build environment is properly configured
