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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
