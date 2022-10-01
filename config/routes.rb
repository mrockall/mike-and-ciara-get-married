Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/manage', as: 'rails_admin'

  post 'answer', to: 'application#answer'

  get 'details-of-the-day', to: 'application#details_of_the_day'
  get 'where-to-stay', to: 'application#where_to_stay'
  get 'rsvp', to: 'application#rsvp'

  get 'games', to: 'games#index'
  get 'games/:key', to: 'games#game'

  root 'application#index'
end
