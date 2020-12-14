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
    postgresql-dev \ 
    ruby-nokogiri --no-cache \
    git \
    bash \
    vim \ 
    sqlite \ 
    sqlite-dev
RUN apk add --no-cache tzdata
ENV TZ America/Sao_Paulo

RUN gem install bundler
RUN bundle install
RUN rails db:migrate
RUN chmod 777 -R /users_api
