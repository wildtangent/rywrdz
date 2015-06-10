Rails.application.routes.draw do
  resources :rewards, only: :index, format: :json
end
