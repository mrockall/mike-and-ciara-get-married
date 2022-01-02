FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
ENV EDITOR="vim"
RUN mkdir /wedding-trivia
WORKDIR /wedding-trivia
COPY Gemfile /wedding-trivia/Gemfile
COPY Gemfile.lock /wedding-trivia/Gemfile.lock
RUN bundle install
COPY . /wedding-trivia
RUN chmod +x ./bin/release-tasks.sh
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]