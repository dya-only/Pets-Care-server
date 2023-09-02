Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Login & Signup
  post '/api/auth/signup' => 'auth#sign_up', controller: 'auth'
  post '/api/auth/login' => 'auth#login', controller: 'auth'
  post '/api/auth/verify' => 'auth#verify', controller: 'auth'

  # User
  get '/api/user' => 'user#getAll', controller: 'user'
  get '/api/user/:id' => 'user#findById', controller: 'user'
  get '/api/user/likes/:id' => 'user#getLikes', controller: 'user'
  patch '/api/user/avatar' => 'user#uploadAvatar', controller: 'user'

  # Hospital
  post '/api/hosp/add' => 'hosp#add', controller: 'hosp'
  post '/api/hosp/remove' => 'hosp#remove', controller: 'hosp'
end