# https://jbhannah.net/articles/rails-development-with-docker/
FROM ruby:2-slim

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update \
    	&& apt-get install -y --no-install-recommends sudo curl \
    	&& curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \
        && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
        && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    	&& apt-get install -y --no-install-recommends \
            git \
            build-essential \
            patch \
            zlib1g-dev \
            liblzma-dev \
            graphviz \
            libmysqlclient-dev \
            libxml2-dev \
            libxslt-dev \
            nodejs \
            yarn \
    	&& rm -rf /var/lib/apt/lists/*

EXPOSE 3000

ENV BUNDLE_PATH /ruby_gems

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
