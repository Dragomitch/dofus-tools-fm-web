## Dofus Tools

Un site proposant divers outils pour se simplifier la vie sur Dofus.

**Status**: 🔄 Major Migration in Progress (Wave 0/5)

---

## Documentation

Complete documentation for the Dofus Tools project is available in the [/docs](./docs/) directory:

- **[Overview](./docs/README.md)** - Documentation index and navigation
- **[Developer Setup](./docs/guides/developer-setup.md)** - Get your development environment running
- **[Architecture](./docs/architecture/README.md)** - System design and technical decisions
- **[API Documentation](./docs/api/README.md)** - API endpoints and integration
- **[Deployment Guide](./docs/deployment/README.md)** - How to deploy the application
- **[User Guide](./docs/guides/user-guide.md)** - End-user documentation (French)

---

## Migration Information

This project is undergoing a major migration to modernize the technology stack:

### Target Stack
- **Backend**: Java 26 + Spring Boot 3.x
- **Frontend**: Angular 20
- **Database**: PostgreSQL
- **Build Tools**: Maven/Gradle, npm

### Migration Status
- **Wave 0** ✅ (Nov 8, 2025): Documentation & Setup
- **Wave 1** 🔄 (In Progress): Backend Infrastructure
- **Wave 2** ⏳ (Pending): Frontend Migration
- **Wave 3** ⏳ (Pending): Integration & Testing
- **Wave 4** ⏳ (Pending): Performance & Security
- **Wave 5** ⏳ (Pending): Deployment & Release

For detailed migration plans, see:
- [MIGRATION_PRD.md](./MIGRATION_PRD.md) - Product Requirements Document
- [IMPLEMENTATION_BOOK.md](./IMPLEMENTATION_BOOK.md) - Implementation Strategy
- [TASK_EXECUTION_MATRIX.md](./TASK_EXECUTION_MATRIX.md) - Task Tracking

---

## Quick Start

### For Developers

1. **Clone the repository**:
   ```bash
   git clone https://github.com/N3ROO/dofus-tools.git
   cd dofus-tools-fm-web
   ```

2. **Follow the [Developer Setup Guide](./docs/guides/developer-setup.md)**

3. **Run the application**:
   ```bash
   # Terminal 1 - Backend (Java 26 + Spring Boot)
   cd backend && ./mvnw spring-boot:run

   # Terminal 2 - Frontend (Angular)
   cd frontend && npm start
   ```

### For Users

1. **Visit**: https://dofus-tools.com
2. **Read**: [User Guide](./docs/guides/user-guide.md) (French)

---

## Legacy Scripts (Python)

**Note**: Legacy Python scripts are being migrated to the new backend. See [Migration Status](#migration-status) above.

To run legacy Python scripts:
- Installer python, et vérifier que la commande "python" fonctionne dans un terminal,
- Ouvrir un terminal à la racine du projet,
- Ecrire "python py/<nom_du_script>" pour l'exécuter.

Si le terminal indique que vous n'avez pas certains modules, alors installez-les avec la commande :
- python -m pip install <module>

---

## Getting Help

- 📚 **Documentation**: Check the [/docs](./docs/) directory
- 🐛 **Report Issues**: Create an issue on GitHub
- 💬 **Discussions**: Join our community discussions
- 📧 **Contact**: See documentation for contact information

---

## Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

For more details, see [Developer Setup](./docs/guides/developer-setup.md).

---

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---

## Project Info

- **Repository**: https://github.com/N3ROO/dofus-tools
- **Maintainer**: N3ROO
- **Last Updated**: November 8, 2025
- **Version**: 0.9.0 (Pre-release - Wave 0)
