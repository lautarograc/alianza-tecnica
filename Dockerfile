FROM ruby:3.1.2
ENV BUNDLER_VERSION=2.3.25
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler -v 2.3.25
WORKDIR /t-cnica
COPY Gemfile /t-cnica/Gemfile
COPY Gemfile.lock /t-cnica/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]