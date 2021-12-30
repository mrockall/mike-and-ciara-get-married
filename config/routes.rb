Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/manage', as: 'rails_admin'

  post 'answer', to: 'application#answer'

  root 'application#index'
end
