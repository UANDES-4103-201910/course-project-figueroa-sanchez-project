Rails.application.routes.draw do
  get 'registration/index'
  get 'change_password/index'
  get 'recover_password/index'
  get 'profile_view/index'
  get 'searcher/index'
  get 'login/index'
  root :to => 'home#home'
  resources :black_lists
  resources :admin_locations
  resources :reports
  resources :comments
  resources :shared_posts
  resources :dumpsters
  resources :profiles
  resources :users
  resources :login
  resources :searcher
  resources :profile_view
  defaults format: :json do
    resources :users, :posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
