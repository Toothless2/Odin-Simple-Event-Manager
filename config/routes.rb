Rails.application.routes.draw do

  resources :events
  #need to add before resources :users to work properly
  post '/users/login', :to => 'users#newlogin', :as => 'user_login'
  get '/users/logout', :to => 'users#logout', :as => 'logout'

  resources :users

  root 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
