QsiGrupoFacultad::Application.routes.draw do
  get "feeds/index"
  root :to => "feeds#index"

  devise_for :users, :controllers => {
    :registrations      => "registrations",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :users

  resources :feeds

  post 'add_feed_tags', to: 'feeds#add_feed_tags', as: 'add_feed_tags'
end
