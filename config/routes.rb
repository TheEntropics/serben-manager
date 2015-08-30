Rails.application.routes.draw do
  root 'application#index'

  resource :user

  get '/login', to: 'users#login', as: 'login'
  post '/login', to: 'users#do_login'
  post '/logout', to: 'users#logout', as: 'logout'


  get '/game/new', to: 'game#new', as: 'new_game'
  post '/game/new', to: 'game#create'
  delete '/:short_name', to: 'game#destroy'
  get '/:short_name', to: 'game#show', as: 'game'
  get '/:short_name/edit', to: 'game#edit', as: 'edit_game'
  put '/:short_name/edit', to: 'game#update'
  post '/:short_name/start', to: 'game#start', as: 'start_game'
  post '/:short_name/stop', to: 'game#stop', as: 'stop_game'
end
