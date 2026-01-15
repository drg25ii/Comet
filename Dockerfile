# Folosește imaginea de bază cu python și uv
FROM ghcr.io/astral-sh/uv:python3.11-alpine

LABEL name="Comet" \
      description="Stremio's fastest torrent/debrid search add-on." \
      url="https://github.com/g0ldyy/comet"

# Instalează dependențele de sistem necesare
RUN apk add --no-cache gcc python3-dev musl-dev linux-headers

WORKDIR /app

# Configurează baza de date
ARG DATABASE_PATH

# Copiază fișierele de configurare a proiectului
COPY pyproject.toml .
RUN apt-get update \
    && apt-get install -y git gcc g++ python3-dev build-essential pkg-config \
    && rm -rf /var/lib/apt/lists/*
RUN uv sync

# Copiază restul codului sursă
COPY . .

# Forțează portul 7860 pentru Hugging Face
ENV PORT=7860
ENV FASTAPI_HOST=0.0.0.0
EXPOSE 7860

# Pornirea aplicației forțând portul 7860
ENTRYPOINT ["uv", "run", "python", "-m", "comet.main", "--port", "7860", "--host", "0.0.0.0"]
