Rails.application.routes.draw do
  namespace :manage do
    resources :questions
  end

  root 'application#index'
end
