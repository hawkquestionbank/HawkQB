Rails.application.routes.draw do
  get 'questions/manage_questions'
  post 'questions/associate_micro_credentials'
  post 'questions/dissociate_micro_credentials'
  post 'questions/clone'
  resources :questions
  resources :multiple_choices, controller: 'questions', type: 'multiple_choice'
  resources :multiple_selects, controller: 'questions', type: 'multiple_select'
  resources :fill_in_the_blanks, controller: 'questions', type: 'fill_in_the_blank'

  get 'micro_credentials/manage_course_micro_credentials'
  post 'micro_credentials/associate_to_course'
  post 'micro_credentials/dissociate_from_course'
  post 'micro_credentials/clone'
  get 'micro_credentials/study'
  resources :micro_credentials

  get 'courses/manage_registrations'
  post 'courses/drop_student'
  post 'courses/self_register_using_token'
  post 'courses/add_student_using_email'

  resources :courses
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, :path_prefix => 'my'
  scope "/admin" do
    resources :users
  end

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

  get "attempts/redirect_to_attempts_show"
  resources :attempts
end
