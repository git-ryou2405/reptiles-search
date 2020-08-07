Rails.application.routes.draw do
  root 'static_pages#top'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  
  resources :users, :only => [:show, :edit] do
    resources :reptiles
  end
  
  get '/users/sign_out' => 'devise/sessions#destroy'

  get '/users', to: 'devise/registrations#new'
  get '/users/password', to: 'devise/passwords#new'
  get '/users/password/edit', to: 'devise/passwords#edit'
end
