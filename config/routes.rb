Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  get 'pages/home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'pages#home'

  get 'about', to: 'pages#about'

  get 'login' => 'pages#login'

  get 'users' => 'pages#users'

end
