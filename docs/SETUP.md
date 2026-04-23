# Setup & Installation Guide

## Prerequisites

- Python 3.9+
- pip and venv
- Docker & Docker Compose (optional)
- Git

## Local Setup

### 1. Clone Repository
```bash
git clone https://github.com/nareshs1624-ops/C-Communication.git
cd C-Communication
```

### 2. Create Virtual Environment
```bash
# Linux/macOS
python -m venv venv
source venv/bin/activate

# Windows
python -m venv venv
venv\Scripts\activate
```

### 3. Install Dependencies
```bash
# Core dependencies
pip install -r requirements.txt

# Development dependencies (optional)
pip install -r requirements-dev.txt
```

### 4. Configure Environment
```bash
# Copy template and edit with your values
cp .env.example .env

# Edit .env with your credentials
nano .env  # or use your preferred editor
```

### 5. Verify Installation
```bash
# Run tests
make test

# Check code quality
make lint
```

## Docker Setup

### Using Docker Compose (Recommended for Development)

```bash
# Build and start all services
make docker-up

# View logs
docker-compose -f docker/docker-compose.yml logs -f

# Stop services
make docker-down
```

Services will be available at:
- Application: `http://localhost:8000`
- PostgreSQL: `localhost:5432`
- Redis: `localhost:6379`
- Qdrant Vector DB: `http://localhost:6333`

### Building Docker Image

```bash
# Build image
make docker-build

# Run container
docker run -p 8000:8000 --env-file .env c-communication:latest
```

## Azure Deployment

### Prerequisites
- Azure CLI installed and authenticated
- Azure Subscription
- Azure Container Registry (optional)

### Deployment Steps

1. **Create Resource Group**:
```bash
az group create --name c-communication-rg --location eastus
```

2. **Deploy to Azure Container Instances**:
```bash
az container create \
  --resource-group c-communication-rg \
  --name c-communication \
  --image c-communication:latest \
  --cpu 2 \
  --memory 2 \
  --ports 8000 \
  --environment-variables \
    ENVIRONMENT=production \
    AZURE_OPENAI_ENDPOINT=$AZURE_OPENAI_ENDPOINT \
    AZURE_OPENAI_KEY=$AZURE_OPENAI_KEY
```

3. **View Deployment Status**:
```bash
az container show --resource-group c-communication-rg --name c-communication
```

## Configuration

### Environment Variables

Key configuration via `.env`:

```
# Application
ENVIRONMENT=development|production
DEBUG=True|False

# Azure OpenAI
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com/
AZURE_OPENAI_KEY=your_key
AZURE_OPENAI_DEPLOYMENT=your_deployment

# Vector Database
QDRANT_URL=http://localhost:6333
PINECONE_API_KEY=your_key

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/db_name
REDIS_URL=redis://localhost:6379/0
```

See `.env.example` for complete list.

## Development Workflow

### Running Tests
```bash
# All tests
make test

# Specific test file
pytest tests/test_models.py -v

# With coverage
pytest --cov=src tests/
```

### Code Quality
```bash
# Format code
make format

# Lint code
make lint

# Type checking
mypy src/
```

### Running Application
```bash
# Local development
python -m src.main

# With Docker
docker-compose -f docker/docker-compose.yml up
```

## Troubleshooting

### Connection Issues
```bash
# Test Azure OpenAI connection
python -c "from src.config.settings import settings; print(settings.azure_openai_endpoint)"

# Test Vector DB connection
python -c "from src.rag.vector_store import VectorStore; VectorStore().health_check()"
```

### Dependency Issues
```bash
# Upgrade pip
pip install --upgrade pip

# Reinstall requirements
pip install --force-reinstall -r requirements.txt
```

### Docker Issues
```bash
# Remove containers and volumes
docker-compose -f docker/docker-compose.yml down -v

# Rebuild from scratch
docker-compose -f docker/docker-compose.yml up --build
```

## Production Deployment

See deployment guides for:
- [Azure Container Instances](../docs/azure-deployment.md)
- [Kubernetes](../docs/k8s-deployment.md)
- [Cloud Functions](../docs/serverless-deployment.md)

## Next Steps

1. Review [ARCHITECTURE.md](ARCHITECTURE.md) for system design
2. Read [Contributing Guidelines](CONTRIBUTING.md)
3. Explore `src/` directory structure
4. Start with example scripts in `examples/`

## Support

For issues, questions, or contributions, please refer to [CONTRIBUTING.md](CONTRIBUTING.md).
