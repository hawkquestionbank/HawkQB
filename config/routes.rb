Rails.application.routes.draw do
  post 'questions/new_multiple_choice'
  resources :questions
  resources :multiple_choices, controller: 'questions', type: 'multiple_choice'
  resources :multiple_selects, controller: 'questions', type: 'multiple_select'

  get 'micro_credentials/study'
  resources :micro_credentials

  get 'courses/manage_registrations'
  post 'courses/self_register_using_token'
  post 'courses/add_student_using_email'

  resources :courses
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  get 'pages/home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'pages#home'

  get 'about', to: 'pages#about'

  get 'login' => 'pages#login'

  get 'users' => 'pages#users'

  get 'admin_dashboard/list'
  get 'student_dashboard/list'
  get 'instructor_dashboard/list'
 
end
