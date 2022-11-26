FROM ruby:2.7.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
ENV EDITOR="vim"
RUN mkdir /wedding
WORKDIR /wedding
COPY Gemfile /wedding/Gemfile
COPY Gemfile.lock /wedding/Gemfile.lock
RUN bundle install
COPY . /wedding
RUN chmod +x ./bin/release-tasks.sh
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
RUN SECRET_KEY_BASE=1 RAILS_ENV=production bundle exec rake assets:precompile
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]