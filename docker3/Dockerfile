FROM python:3-alpine
MAINTAINER autor@um.es

RUN mkdir /directorio
COPY server.py /directorio

WORKDIR /directorio

EXPOSE 9000

CMD ["python", "-u", "server.py"]
