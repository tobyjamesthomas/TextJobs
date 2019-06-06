Rails.application.routes.draw do
  root to: 'users#new'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  resources :users, only: [:new, :create]
  resources :jobs, only: [:new, :create]
end
