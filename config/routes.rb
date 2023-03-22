require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  post 'answer', to: 'application#answer'

  get 'details-of-the-day', to: 'application#details_of_the_day'
  get 'where-to-stay', to: 'application#where_to_stay'
  get 'hair-and-make-up', to: 'application#hair_and_make_up'
  get 'rsvp', to: 'application#rsvp'
  get 'change-of-chapel', to: 'application#change_of_chapel'

  get 'games', to: 'games#index'
  get 'games/leaderboard', to: 'games#leaderboard'
  get 'games/start-over', to: 'games#start_over'
  get 'games/add-name', to: 'games#add_name'
  post 'games/add-name', to: 'games#handle_add_name'
  get 'games/:key', to: 'games#game'
  get 'games/:key/submit-answer/:answer_id', to: 'games#submit_answer'

  root 'application#index'
end
