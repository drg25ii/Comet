FROM ghcr.io/astral-sh/uv:python3.11-alpine

LABEL name="Comet" \
      description="Stremio's fastest torrent/debrid search add-on." \
      url="https://github.com/g0ldyy/comet"

RUN apk add --no-cache \
    git gcc musl-dev python3-dev linux-headers

WORKDIR /app

ARG DATABASE_PATH

COPY pyproject.toml ./
# Fără uv.lock încă - elimină --frozen temporar
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync

COPY . .

ENV PORT=7860
ENV FASTAPI_HOST=0.0.0.0
EXPOSE 7860

ENTRYPOINT ["uv", "run", "python", "-m", "comet.main", "--port", "7860", "--host", "0.0.0.0"]
