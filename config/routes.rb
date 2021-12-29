Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/manage', as: 'rails_admin'

  root 'application#index'
end
