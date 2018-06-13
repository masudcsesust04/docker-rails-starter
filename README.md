# Dockerized rails application 

This README would normally document whatever steps are necessary to get the
application up and running.

Clone the repository 
```
git clone git@github.com:masudcsesust04/docker-rails-starter.git
```

Change or modify rails version in Gemfile if needed. I have used latest rails 5.2.0
Change or modify ruby version in Dockerfile if needed. I have used ruby 2.5.1

Now create a new rails application using docker-compose 
```
docker-compose run app rails new . --force --database=mysql --skip-bundle
```

Edit database.yml file
```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  database: <%= ENV['DB_NAME'] %>
  username: <%= ENV['DB_USER'] %>
  password: <%= ENV['DB_PASSWORD'] %>
  host: <%= ENV['DB_HOST'] %>

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
```

Add following lines under app service in your docker-compose.yml file
```
environment:
  DB_USER: appuser
  DB_NAME: docker-rails-starter
  DB_PASSWORD: password
  DB_HOST: db
```

Run ```docker-compose build``` this will build the docker image and install gems [because we have new gems due to rails new command].

Run ```docker-compose up``` will run the services and application will be up and running.

Visit ```localhost:3001``` wow! showed rails app

Generate a scaffold ```docker-compose run --rm app rails g scaffold post title body:text```

Run migration ```docker-compose run --rm app rake db:migrate```

Now visit ```localhost:3001/posts``` you can see the posts URL with CRUD feaures. FYI, We don't need to restart the service.

###Few more commands

Check the status of the services
```docker-compose ps```

```docker-compose run --rm app rake any_rake_command```

