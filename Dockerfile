FROM elixir:1.6.3-slim

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get && \ 
    mix do compile

CMD ["/app/entrypoint.sh"]
