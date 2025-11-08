# Changelog

All notable changes to the Dofus Tools project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Documentation structure for Wave 0 setup
- Comprehensive developer setup guide
- API documentation template
- Architecture documentation
- Deployment guide
- User guide (French)
- CHANGELOG.md and updated root README

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [1.0.0] - 2025-01-15 (Planned Release)

### Added
- Java 26 + Spring Boot 3.x backend migration
- Angular 20 frontend migration
- PostgreSQL database integration
- JWT-based authentication system
- Comprehensive API endpoints
- User management system
- Tool management features
- Favorite/bookmark functionality
- Complete documentation suite
- Docker containerization
- CI/CD pipeline with GitHub Actions
- Kubernetes deployment configuration

### Changed
- Migrated from legacy Python backend to Spring Boot 3.x
- Migrated from vanilla JavaScript frontend to Angular 20
- Updated database schema for new architecture

### Deprecated
- Legacy Python scripts (will be removed in 2.0.0)
- Original JavaScript frontend (will be removed in 2.0.0)

### Removed

### Fixed

### Security
- Implemented JWT token-based authentication
- Added password hashing with bcrypt
- Implemented CORS security headers
- Added rate limiting for API endpoints

## [0.9.0] - 2024-11-08 (Pre-Release - Wave 0)

### Added
- Migration PRD (Product Requirements Document)
- Implementation Book for migration strategy
- Task Execution Matrix for tracking
- Documentation structure setup
- Developer setup guide
- Architecture documentation
- API documentation framework
- Deployment guide
- User documentation

### Changed
- Prepared codebase for major migration

### Security
- Added security guidelines to documentation

---

## Version History Summary

### Current State (November 8, 2025)

**Project**: Dofus Tools Migration to Java 26 + Spring Boot 3.x + Angular 20

**Status**: Wave 0 - Documentation and Setup Complete

**Completed Milestones**:
- Documentation structure established
- All template files created
- Migration PRD finalized
- Implementation strategy defined
- Task execution matrix ready

**Next Phase**: Wave 1 - Backend Infrastructure & Core Services

---

## How to Contribute to Changelog

When making a pull request:

1. Add your changes to the [Unreleased] section
2. Use these categories:
   - **Added**: New features
   - **Changed**: Changes in existing functionality
   - **Deprecated**: Soon-to-be removed features
   - **Removed**: Removed features
   - **Fixed**: Bug fixes
   - **Security**: Security improvements

3. Follow this format:
   ```
   ### Added
   - [Brief description of the feature] (#PR-number)
   - [Another feature] (#PR-number)
   ```

4. When a new version is released, the Unreleased section becomes a new version section

---

## Release Schedule

| Wave | Version | Target Date | Status |
|------|---------|------------|--------|
| 0 | 0.9.0 | November 8, 2025 | ✅ Complete |
| 1 | 0.9.1 | November 15, 2025 | 🔄 In Progress |
| 2 | 0.9.2 | November 30, 2025 | ⏳ Pending |
| 3 | 0.9.3 | December 15, 2025 | ⏳ Pending |
| 4 | 0.9.4 | January 10, 2026 | ⏳ Pending |
| 5 | 1.0.0 | January 30, 2026 | ⏳ Planned |

---

## Related Documentation

- [Migration PRD](./MIGRATION_PRD.md)
- [Implementation Book](./IMPLEMENTATION_BOOK.md)
- [Task Execution Matrix](./TASK_EXECUTION_MATRIX.md)
- [Documentation Index](./docs/README.md)

---

**Last Updated**: November 8, 2025
**Maintainer**: Dofus Tools Migration Team
