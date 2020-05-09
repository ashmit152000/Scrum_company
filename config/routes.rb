Rails.application.routes.draw do
  devise_for :users
  # get 'welcome/index'
  root to: "welcome#index"
  resources :projects
  resources :memberships, only: [:create]
  # post '/createproject', to: 'projects#ajaxreply'
  get '/add/projects',to: "welcome#projects"
  get 'search_members',to: "projects#search_members"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
