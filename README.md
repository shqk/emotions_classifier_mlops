# Projet MLOps

uvicorn src.main:app --reload

ou

fastapi dev src/main.py

build pour cloud run:
docker buildx build --platform linux/amd64 ...