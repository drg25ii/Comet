# Folosim imaginea oficială Comet de pe Docker Hub (nu GitHub)
FROM g0ldyy/comet:latest

# Setările obligatorii pentru Hugging Face
ENV PORT=7860
ENV HOST=0.0.0.0
ENV COMET_PORT=7860
ENV COMET_HOST=0.0.0.0

# Expunem portul
EXPOSE 7860

# Pornim Comet (imaginea oficială are deja setat entrypoint-ul, 
# dar îl forțăm pe portul corect dacă e nevoie)
CMD ["python", "-m", "comet.main"]
