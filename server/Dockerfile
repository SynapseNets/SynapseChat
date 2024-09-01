FROM python:3.12-alpine

COPY requirements.txt .
RUN apk update
RUN apk add pkgconfig
RUN apk add --no-cache gcc musl-dev mariadb-connector-c-dev openssl
RUN pip install --no-cache-dir -r requirements.txt

COPY . /server
WORKDIR /server
RUN /bin/sh init.sh
# RUN mkdir logs

CMD ["python", "main.py"]