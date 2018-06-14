# Base image:
FROM ruby:2.5.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Create a directory where the rails app is installed inside of Docker image:
RUN mkdir /docker-rails-starter

# Set working directory, where the command will be ran:
WORKDIR /docker-rails-starter

# Add Gmefile and Gemfile.lock to the working direcotry
ADD Gemfile /docker-rails-starter/Gemfile
ADD Gemfile.lock /docker-rails-starter/Gemfile.lock

# Install bundler gem
RUN gem install bundler

# Install gems
RUN bundle install


# Add current directory to the application directory to the Docker image
ADD . /docker-rails-starter

