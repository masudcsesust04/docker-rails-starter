# Dockerized rails application 

Simple docker configuration to start a rails application with mysql database.

Clone the repository.
```
git clone git@github.com:masudcsesust04/docker-rails-starter.git
```

You can change ruby(using latest 2.5.1) version in ```Dockerfile``` if needed.

Also, You can change/modify rails(used latest rails 5.2.0) version in ```Gemfile``` if needed.

Now create rails application using docker-compose. It will pull and download all of the dependent images(ex- ruby and mysql) 
specified in ```Dockerfile``` and ```docker-compose.yml``` file. Then it will create a rails application with mysql configuration skipping the bundle installation.
```
docker-compose run app rails new . --force --database=mysql --skip-bundle
```

Ok. Now edit your ```config/database.yml``` file as per bellow.
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

Now we need to specify the database environment configuration. So, Let's add following lines to ```docker-compose``` file under ```app``` service.
```
environment:
  DB_USER: appuser
  DB_NAME: docker-rails-starter
  DB_PASSWORD: password
  DB_HOST: db
```

Alright, Now we are ready to build our application docker image. This will run all of the instructions specified in ```Dockerfile```. Run following command to build the application.   
```
docker-compose build
``` 

Let's run all the services specified in ```docker-compose.yml``` file. Now you will see rails application is up and running.
```
docker-compose up
```

Ok, Now open your browser and visit ```localhost:3001``` wow! you will be seeing rails app default page. It seems dockerized rails application is running properly.

Now it's time to generate a scaffold using ```rails``` generator. We will be creating a ```post``` scaffold with ```title``` and ```body``` fields.
```
docker-compose run --rm app rails g scaffold post title body:text
```

Alright, Now we need to run the migration which is create due to the scaffolding.
```
docker-compose run --rm app rake db:migrate
```

Now visit ```localhost:3001/posts``` you will see the posts index page with add, edit, delete posts. 

Note: We don't need to restart the service. I mean rebuild the image and re-run the ```docker-compose up```.

### important commands

To check the status of the services run 
```
docker-compose ps
```

You can run almost all the ```rake``` commands by specifying the task name as bellow  
```
docker-compose run --rm app rake any_rake_command
```

