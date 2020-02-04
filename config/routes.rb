Rails.application.routes.draw do
  resources :tests, only: :index
  resources :statistics, only: :index
end
