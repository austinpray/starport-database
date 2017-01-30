# Starport Database

## Run with Docker

Install [Docker][] on your system. [Install Guide][Install Docker].

Install the deps

```
docker-compose run --rm web bundle install
```

Run the app

```
docker-compose up
```

It should now be running at [http://localhost:3001](http://localhost:3001)

## Run Standalone

Needs Ruby 2.4

[Docker]: https://www.docker.com/
[Install Docker]: https://docs.docker.com/engine/installation/
