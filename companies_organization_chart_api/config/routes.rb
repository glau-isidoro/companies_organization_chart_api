Rails.application.routes.draw do
  namespace :api do
    resources :companies, only: [:index, :create, :show] do
      resources :employees, only: [:index, :create, :destroy]
    end
  end
end
