Rails.application.routes.draw do
  root 'static_pages#top'
  
  devise_for :users, controllers: {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations',
    :sessions      => "users/sessions",
    :passwords     => "users/passwords"
  }
  devise_scope :user do
    get '/users/delete_photo' => 'users/registrations#delete_photo'
  end

  get '/users/sign_out' => 'devise/sessions#destroy'
  get '/users', to: 'devise/registrations#new'
  get '/users/password', to: 'devise/passwords#new'
  get '/users/password/edit', to: 'devise/passwords#edit'
  
  get 'reptiles/search' => 'reptiles#search'
  
  resources :users, :only => [:show, :edit] do
    resources :reptiles
  end
end
