Rails.application.routes.draw do
  root 'pages#index'

  resources :users 
  get    'signup'             => "users#new", as: :signup
  get    'login'              => "sessions#login"
  post   'login-attempt'      => "sessions#login_attempt"
  get    'logout'             => "sessions#logout"

  resources :tasks, except: :show
  post 'tasks/:id/complete'   => "tasks#complete"
end
