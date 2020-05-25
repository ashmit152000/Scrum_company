Rails.application.routes.draw do
  get 'assignments/new'
  devise_for :users
  # get 'welcome/index'
  root to: "welcome#index"
  resources :projects do 
    resources :assignments
  end
  resources :memberships, only: [:create,:destroy]
  resources :requests, only: [:create,:destroy,:index]
  # post '/createproject', to: 'projects#ajaxreply'
  get '/add/projects',to: "welcome#projects"
  get 'search_members',to: "projects#search_members"
  get 'request_projects',to: "projects#request_projects"
  get 'accept_requests',to: "requests#accept"
  post 'accept_requests',to: "request#accept"
  get 'decline_requests',to: "requests#decline"
  post 'decline_requests',to: "requests#decline" 
  get 'add_label',to:"assignments#add_label"
  post 'add_label',to:"assignments#add_label"
  # get 'show_assignments',to: "assignments#admin"
  get 'show_assignments/user/:user_id/project/:project_id',to: "assignments#admin", as: :show_assignments

  post 'accept_assignment/:id/project/:project_id', to: "assignments#accept", as: :accept_assignment
  post 'reject_assignment/:id/project/:project_id',to: "assignments#reject", as: :reject_assignment

  post 'submit_completed/:id/project/:project_id', to: "assignments#completed", as: :completed

  post 'ratings', to: "assignments#ratings", as: :ratings

  get 'user/:id/', to: "projects#user_show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
