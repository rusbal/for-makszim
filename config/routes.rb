Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  devise_for :users

  namespace :v1, { defaults: { format: :json } } do
    resources :albums
    resources :photos
    resources :users
  end
end
