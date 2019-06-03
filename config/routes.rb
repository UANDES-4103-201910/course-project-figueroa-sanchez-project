Rails.application.routes.draw do
  resources :follow_posts
  get 'posts/new_comment', to:'posts#new_comment', as: 'new_comment_post'
  get 'profiles/new_comment', to:'profiles#new_comment', as: 'new_comment_prof'
  get 'posts/vote_up', to:'posts#vote_up', as: 'vote_up'
  get 'posts/vote_down', to:'posts#vote_down', as: 'vote_down'
  get 'posts/follow_post', to:'posts#follow_post', as: 'followpost'
  get 'destroy/searcher'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', :registrations => "users/registrations"}
  get 'admin_list/', to:'admin_list#index'
  get 'super_admin_home/', to: 'super_admin_home#index', as: "super_admin_home"
  get 'admin_home/', to: 'admin_home#index', as: "admin_home"
  get 'user_list/', to: 'user_list#index'
  get 'report_post/:id', to: 'report_post#index'
  get 'post_view/:id', to: 'post_view#index'
  get 'registration/', to: 'registration#index'
  get 'searches/', to: 'searches#new'
  get 'change_password/index'
  get 'recover_password/index'
  get 'profile_view/index'
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
  resources :searches
  resources :profile_view
  resources :post_view
  resources :user_roles
  post '/user_roles/:id', to: 'user_roles#create', as: 'make_admin'
  post '/black_list/:id', to: 'black_lists#create', as: 'black_list_user'
  post '/ban_users/:id', to: 'users#ban_user', as: 'ban_user'
  resources :users, :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
