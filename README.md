# Mike & Ciara Get Married

Repo containing the website that details all of our wedding details. It's mostly for that, but also just because I want to mess with some stuff like Docker, Heroku, Rails and Tailwind.

# Development Commands

I'm still figuring all of this stuff out. Will add new commands here so I don't forget them.

```
# To bring up the development site locally
docker compose up

# To edit the credentials within the container
docker exec -it wedding-trivia-web-1 bin/rails credentials:edit

# To run normal rails commands inside the container:
docker compose run web CMD
e.g. docker compose run web rake --tasks
e.g. docker compose run web rails db:create
```

# Links to Resources that I Found Useful

1. https://github.com/nickjj/docker-rails-example
2. https://nickjanetakis.com/blog/best-practices-around-production-ready-web-apps-with-docker-compose
