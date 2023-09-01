Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api/user' => 'user#getAll', controller: 'user'
  get '/api/user/:id' => 'user#findById', controller: 'user'
  patch '/api/user/avatar' => 'user#uploadAvatar', controller: 'user'

  post '/api/auth/signup' => 'auth#sign_up', controller: 'auth'
  post '/api/auth/login' => 'auth#login', controller: 'auth'

  post '/api/cafe/add' => 'cafe#add', controller: 'cafe'
  post '/api/cafe/remove' => 'cafe#remove', controller: 'cafe'
  post '/api/cafe/likes' => 'cafe#getLikes', controller: 'cafe'
end