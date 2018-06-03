Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :companies, only: [:index, :create, :show]
  end
end
