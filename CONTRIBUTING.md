# Contributing to C-Communication

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## Development Setup

1. **Fork and clone** the repository:
```bash
git clone https://github.com/nareshs1624-ops/C-Communication.git
cd C-Communication
```

2. **Create a virtual environment**:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install development dependencies**:
```bash
make dev-install
```

4. **Create a feature branch**:
```bash
git checkout -b feature/your-feature-name
```

## Code Standards

### Python Style Guide
- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- Use type hints for all functions
- Docstrings required for all modules, functions, and classes

### Formatting
```bash
# Format code with black
make format

# Check linting
make lint
```

### Testing
- Write tests for all new functionality
- Maintain >80% code coverage
- Run tests before submitting PR:
```bash
make test
```

## Commit Guidelines

- Use clear, descriptive commit messages
- Prefix with type: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`
- Examples:
  - `feat: implement RAG pipeline component`
  - `fix: correct vector database connection timeout`
  - `docs: update RAG architecture documentation`

## Pull Request Process

1. **Ensure tests pass**:
```bash
make test
```

2. **Format and lint code**:
```bash
make format
make lint
```

3. **Create PR with clear description**:
   - What problem does it solve?
   - What changes were made?
   - Any breaking changes?

4. **Link to related issues**:
   - Use "Closes #123" syntax

## Project Structure

```
src/
├── config/          # Configuration management
├── models/          # LLM model implementations
├── rag/             # RAG pipeline components
├── agents/          # Agentic AI workflows
└── utils/           # Utility functions

tests/
└── test_*.py        # Test files mirroring src structure
```

## Areas for Contribution

### High Priority
- [ ] LLM integration framework
- [ ] RAG pipeline implementation
- [ ] Vector database abstraction layer
- [ ] Azure OpenAI integration

### Medium Priority
- [ ] Agentic AI workflows
- [ ] Monitoring and observability
- [ ] Documentation improvements

### Low Priority
- [ ] Code examples
- [ ] Performance optimizations
- [ ] Additional cloud provider support

## Questions?

- Open an issue for bugs or feature requests
- Use discussions for questions
- Check existing documentation in `docs/`

## Code of Conduct

- Be respectful and inclusive
- Focus on the work, not individuals
- Help others learn and grow

Happy contributing! 🚀
