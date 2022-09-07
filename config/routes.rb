Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "conversations#index"

  resource :messages, only: [:new, :show, :create]
end
