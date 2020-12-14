FROM ruby:2.7-alpine
COPY . /users_api
COPY . /users_api
WORKDIR /users_api
RUN apk update
RUN apk add build-base \
    curl \
    curl-dev \
    libcurl \
    libpq \
    libxml2-dev \
    libxslt-dev \
    openjdk8 \
    postgresql-dev \ 
    ruby-nokogiri --no-cache
RUN apk add --no-cache tzdata
ENV TZ America/Sao_Paulo

RUN apk add git
RUN apk add bash
RUN apk add vim
RUN apk add sqlite

RUN gem install bundler
RUN chmod 777 -R /users_api
