Rails.application.routes.draw do

  #need to add before resources :users to work properly
  post '/users/login', :to => 'users#newlogin', :as => 'user_login'
  get '/users/logout', :to => 'users#logout', :as => 'logout'
  get '/events/goto/:eventid', :to => 'events#goToEvent', :as => 'goto'

  resources :events
  resources :users, only: [:index, :show, :new, :create]

  root 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
