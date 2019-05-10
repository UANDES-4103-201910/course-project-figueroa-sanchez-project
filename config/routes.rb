Rails.application.routes.draw do
  get 'super_admin_home/', to: 'super_admin_home#index'
  get 'admin_home/', to: 'admin_home#index'
  get 'user_list/', to: 'user_list#index'
  get 'report_post/:id', to: 'report_post#index'
  get 'post_view/:id', to: 'post_view#index'
  get 'post_view/post'
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
  resources :login
  resources :searcher
  resources :profile_view
  resources :post_view
  defaults format: :json do
    resources :users, :posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
