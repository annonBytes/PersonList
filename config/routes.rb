Rails.application.routes.draw do
  resources :people

  scope "/api", defaults: {format: :json} do
    resources :people
  end

  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
end
