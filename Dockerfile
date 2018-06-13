FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /docker-rails-starter
WORKDIR /docker-rails-starter

ADD Gemfile /docker-rails-starter/Gemfile
ADD Gemfile.lock /docker-rails-starter/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /docker-rails-starter

