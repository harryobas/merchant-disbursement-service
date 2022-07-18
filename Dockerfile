FROM ruby:2.6.6

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app/

RUN gem install bundler -v 2.0.2

RUN gem install rubygems-update
RUN update_rubygems
RUN gem update --system

RUN bundle _2.0.2_ install

COPY . /usr/src/app

CMD ["rails", "s", "-b", "0.0.0.0"]
