FROM python:3.8.13-slim-bullseye
RUN apt-get -y update && apt-get install -y libpango-1.0-0 libcairo2 libpq-dev libpangocairo-1.0-0  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app


ENV APP=/app



WORKDIR /app
RUN addgroup --system app && adduser --system --group app

RUN mkdir $APP/staticfiles
RUN mkdir $APP/media

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR $APP

COPY ./requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

COPY . $APP/
# copy entrypoint.sh
RUN sed -i 's/\r$//g' $APP/entrypoint.sh

RUN chmod +x $APP/entrypoint.sh
# RUN chmod -R 777 /app/django_azure/staticfiles

RUN chown -R root:root $APP

EXPOSE 8000

# run entrypoint.sh
CMD ["/app/entrypoint.sh"]

