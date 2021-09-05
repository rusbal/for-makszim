Rails.application.routes.draw do
  devise_for :users
  get 'photos/show'

  namespace :v1, { defaults: { format: :json } } do
    resources :albums
    resources :photos
  end
end
