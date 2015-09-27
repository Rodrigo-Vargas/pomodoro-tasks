Rails.application.routes.draw do
  root 'pages#index'
  get 'dashboard'                          => 'pages#dashboard', as: :dashboard
  get 'dashboard/task/:current_task_id'    => 'pages#dashboard', as: :dashboard_task

  resources :users 
  get    'signup'                          => "users#new", as: :signup
  get    'login'                           => "sessions#login"
  post   'login-attempt'                   => "sessions#login_attempt"
  get    'logout'                          => "sessions#logout"
  
  resources :projects do
    resources :tasks
  end

  post 'projects/:project_id/tasks/:id/complete'      => "tasks#complete"
  post '/projects/:project_id/tasks/:id/add-pomodoro' => "tasks#add_pomodoro"
end
