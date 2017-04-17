# Starport Database

## TODO and Code Quality

This is a one-off school project for a database class. The primary effort was in the schema. The interface was essentially an afterthought for a flashy demo. As such: this is not a very good example of quality rails code. This app needs help in the following areas:

- DRY up controllers
- Make controllers leaner
- Organize controllers better (welcome_controller)
- Copy pasted template partials

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
