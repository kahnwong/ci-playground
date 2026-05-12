FROM python:3.14
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# install mlflow
# hadolint ignore=DL3045
COPY pyproject.toml uv.lock README.md ./
RUN uv sync --frozen --no-dev

