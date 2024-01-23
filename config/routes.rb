Rails.application.routes.draw do
  root 'homepage#index'
  get '/feeds' => 'feeds#index'

  # USERS
  post '/users', to: 'users#create'
  
  # SESSIONS
  delete '/session', to: 'sessions#authenticated'
  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'

  # TWEETS
  post '/tweets', to: 'tweets#create'
  get '/tweets', to: 'tweets#index'
  get '/users/:username/tweets', to: 'tweets#index_by_user'

  # Redirect all other paths to index page, which will be taken over by AngularJS
  get '*path' => 'homepage#index'
end
