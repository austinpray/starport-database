# Starport Database

## Run with Docker

>Docker automates the repetitive tasks of setting up and configuring development environments so that developers can focus on what matters: building great software.

[Learn more about what docker is.][Docker what]

Install [Docker][] on your system. [Install Guide][Install Docker].

Install the deps

```
docker-compose run --rm web bundle install
```

Create the db and run the migrations

```
docker-compose run --rm web bin/rails db:create
docker-compose run --rm web bin/rails db:migrate
```

Run the app

```
docker-compose up
```

It should now be running at [http://localhost:3001](http://localhost:3001)

## Run Standalone

Needs Ruby 2.4 and postgres installed on your computer

[Docker]: https://www.docker.com/
[Install Docker]: https://docs.docker.com/engine/installation/
[Docker what]: https://www.docker.com/what-docker
