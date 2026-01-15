# Folosește imaginea de bază cu python și uv pe Alpine
FROM ghcr.io/astral-sh/uv:python3.11-alpine

LABEL name="Comet" \
      description="Stremio's fastest torrent/debrid search add-on." \
      url="https://github.com/g0ldyy/comet"

# Instalează dependențele de sistem necesare pentru compilare și Git
RUN apk add --no-cache \
    git \
    gcc \
    musl-dev \
    python3-dev \
    linux-headers

WORKDIR /app

# Configurează baza de date
ARG DATABASE_PATH

# Copiază fișierele de configurare a proiectului (pentru caching eficient)
COPY pyproject.toml uv.lock* ./

# Sincronizează dependențele (folosește --frozen dacă nu ai uv.lock)
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen

# Copiază restul codului sursă
COPY . .

# Forțează portul 7860 pentru Hugging Face
ENV PORT=7860
ENV FASTAPI_HOST=0.0.0.0
EXPOSE 7860

# Pornirea aplicației
ENTRYPOINT ["uv", "run", "python", "-m", "comet.main", "--port", "7860", "--host", "0.0.0.0"]
