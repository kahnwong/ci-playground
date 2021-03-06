# adapted from https://github.com/beancount/fava/blob/main/contrib/docker/Dockerfile
# gunicorn ref: https://flask.palletsprojects.com/en/1.1.x/deploying/wsgi-standalone/#gunicorn

FROM python:3.10-alpine as builder

RUN apk add --update libxml2-dev libxslt-dev gcc musl-dev g++
RUN pip install --prefix="/install" fava gunicorn

FROM python:alpine

COPY --from=builder /install /usr/local

COPY ./wsgi.py /
# ENV FAVA_HOST "0.0.0.0"
# EXPOSE 8000
CMD ["gunicorn", "-b", "0.0.0.0:5000", "wsgi:app", "--reload"]
