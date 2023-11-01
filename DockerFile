FROM python:3.8.13-slim-bullseye
RUN apt-get -y update && apt-get install -y libpango-1.0-0 libcairo2 libpq-dev libpangocairo-1.0-0  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

WORKDIR /app


ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

COPY *.env.local /app/

# copy entrypoint.sh
# COPY ./entrypoint.local.sh .
# RUN sed -i 's/\r$//g' /app/entrypoint.local.sh

# RUN chmod +x /app/entrypoint.local.sh

EXPOSE 8000

# run entrypoint.sh
CMD ["/app/entrypoint.sh"]

