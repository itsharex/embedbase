FROM python:3.10-slim
# TODO: alpine / scratch

ENV PYTHONUNBUFFERED True

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

ENV PORT 8080

RUN pip install --no-cache-dir -r requirements.txt
# multi-qa-MiniLM-L6-cos-v1
RUN python -c "import os; from sentence_transformers import SentenceTransformer; SentenceTransformer('sentence-transformers/multi-qa-MiniLM-L6-cos-v1')"
# As an example here we're running the web service with one worker on uvicorn.
CMD exec uvicorn api:app --host 0.0.0.0 --port ${PORT} --workers 1