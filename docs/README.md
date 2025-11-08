# Dofus Tools Documentation

Welcome to the comprehensive documentation for the Dofus Tools migration project.

## Documentation Structure

This documentation is organized into the following sections:

### [API Documentation](./api/README.md)
Technical reference for all API endpoints, data structures, and integration points. Includes request/response examples and error handling.

### [Architecture Documentation](./architecture/README.md)
System design, technical decisions, component interactions, and overall system architecture. Reference for understanding how the system is organized.

### [Deployment Guide](./deployment/README.md)
Instructions for deploying the application to different environments (development, staging, production). Includes configuration, environment variables, and troubleshooting.

### [Developer Guides](./guides/)
- [Developer Setup Guide](./guides/developer-setup.md) - Get your development environment running
- [User Guide](./guides/user-guide.md) - End-user documentation for Dofus Tools features

## Quick Navigation

| Section | Purpose | Audience |
|---------|---------|----------|
| API | API endpoints and integration | Backend developers, API consumers |
| Architecture | System design and components | All developers, architects |
| Deployment | Environment setup and deployment | DevOps, system administrators |
| Developer Setup | Local development environment | Developers |
| User Guide | How to use the application | End users |

## Migration Status

This project is undergoing a major migration from a legacy stack to:
- **Backend**: Java 26 + Spring Boot 3.x
- **Frontend**: Angular 20
- **Database**: PostgreSQL
- **Build Tools**: Maven/Gradle, npm

For detailed migration information, see the root-level [MIGRATION_PRD.md](../MIGRATION_PRD.md) and [IMPLEMENTATION_BOOK.md](../IMPLEMENTATION_BOOK.md).

## Getting Help

- Check the relevant documentation section for your use case
- Review the [Developer Setup Guide](./guides/developer-setup.md) if you're new to the project
- For API questions, see the [API Documentation](./api/README.md)
- For deployment questions, see the [Deployment Guide](./deployment/README.md)

## Contributing to Documentation

When updating documentation:
1. Keep language clear and concise
2. Use technical documentation best practices
3. Update the table of contents when adding new sections
4. Test all provided code examples
5. Maintain French for user-facing documentation where applicable

---

**Last Updated**: November 8, 2025
