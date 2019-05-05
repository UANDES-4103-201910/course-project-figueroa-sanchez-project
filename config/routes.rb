Rails.application.routes.draw do
  root :to => 'home#home'
  resources :admin_black_lists
  resources :user_roles
  resources :roles
  resources :black_lists
  resources :admin_locations
  resources :reports
  resources :comments
  resources :validations
  resources :shared_posts
  resources :dumpsters
  resources :attachments
  resources :profile_photos
  resources :profile_locations
  resources :profiles
  resources :user_passwords
  defaults format: :json do
    resources :users, :posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
