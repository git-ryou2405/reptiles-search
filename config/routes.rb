Rails.application.routes.draw do
  root 'static_pages#top'
  get 'alljapan_page' => 'static_pages#alljapan_page'
  get 'shop_page' => 'static_pages#shop_page'
  
  devise_for :users, controllers: {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations',
    :sessions      => "users/sessions",
    :passwords     => "users/passwords"
  }
  devise_scope :user do
    delete '/users/delete_photo' => 'users/registrations#delete_photo'
    get '/users/delete_photos' => 'users/registrations#delete_photos'
  end

  get '/users/sign_out' => 'devise/sessions#destroy'
  get '/users', to: 'devise/registrations#new'
  get '/users/password', to: 'devise/passwords#new'
  get '/users/password/edit', to: 'devise/passwords#edit'
  
  resources :users, :only => [:show, :edit] do
    resources :reptiles
  end
end
