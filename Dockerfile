FROM ruby:3.1.2

ARG RAILS_ENV=development

ENV BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_IGNORE_MESSAGES=1 \
    BUNDLE_GITHUB_HTTPS=1 \
    MAIN_DATABASE_URL={MAIN_DATABASE_URL} \
#    BUNDLE_FROZEN=1 \
#    BUNDLE_WITHOUT=development:test \
    LANG=C.UTF-8 \
    RAILS_ENV=${RAILS_ENV} \
    RACK_ENV=${RAILS_ENV} \
    RAKE_ENV=${RAILS_ENV}

WORKDIR /app

COPY . .

RUN gem install bundler

RUN apt-get update && apt-get install gcc pkg-config imagemagick build-essential vim bash tzdata -y

RUN bundle install -j 4

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]