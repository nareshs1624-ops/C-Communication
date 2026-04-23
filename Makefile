.PHONY: help install install-dev dev-server test lint format clean docker-up docker-down docker-build docker-logs migrate-db migrations-create security-check

.DEFAULT_GOAL := help

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'

# Installation
install: ## Install production dependencies
	pip install --upgrade pip setuptools wheel
	pip install -r requirements.txt

install-dev: install ## Install development dependencies
	pip install -r requirements-dev.txt
	pre-commit install

# Development
dev-server: ## Run development server with hot-reload
	uvicorn src.main:app --reload --host 0.0.0.0 --port 8000

run: ## Run production server
	uvicorn src.main:app --host 0.0.0.0 --port 8000 --workers 4

# Testing & Quality
test: ## Run tests with coverage
	pytest --cov=src --cov-report=html --cov-report=term-missing

test-fast: ## Run tests without coverage
	pytest -x

test-verbose: ## Run tests with verbose output
	pytest -v --tb=long

lint: ## Check code quality (flake8, mypy, black)
	flake8 src tests
	mypy src
	black --check src tests
	isort --check-only src tests

format: ## Auto-format code (black, isort)
	black src tests
	isort src tests

security-check: ## Run security checks (bandit)
	bandit -r src -ll

# Database
migrate-db: ## Run database migrations
	alembic upgrade head

migrations-create: ## Create new database migration
	@read -p "Enter migration message: " msg; \
	alembic revision --autogenerate -m "$$msg"

# Docker
docker-build: ## Build Docker image
	docker build -f docker/Dockerfile -t c-communication:latest .

docker-up: ## Start all services (docker-compose)
	docker-compose -f docker/docker-compose.yml up -d

	@echo "Services started:"
	@echo "  - API: http://localhost:8000"
	@echo "  - API Docs: http://localhost:8000/docs"
	@echo "  - PostgreSQL: localhost:5432"
	@echo "  - Redis: localhost:6379"
	@echo "  - Qdrant: http://localhost:6333"
	@echo "  - pgAdmin: http://localhost:5050"

docker-down: ## Stop all services
	docker-compose -f docker/docker-compose.yml down

docker-logs: ## View docker-compose logs
	docker-compose -f docker/docker-compose.yml logs -f

docker-clean: ## Remove docker containers and volumes
	docker-compose -f docker/docker-compose.yml down -v

# Cleanup
clean: ## Clean build artifacts
	find . -type f -name '*.py[cod]' -delete
	find . -type d -name '__pycache__' -delete
	rm -rf build/ dist/ *.egg-info htmlcov/ .coverage .pytest_cache .mypy_cache

clean-all: clean docker-clean ## Clean everything

# Documentation
docs-build: ## Build documentation
	sphinx-build -b html docs docs/_build

docs-clean: ## Clean documentation build
	rm -rf docs/_build
