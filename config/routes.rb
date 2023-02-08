Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/user", to: "user#index"
  post "/user/create", to: "user#create"
  post "/auth/login", to: "authentication#login"
  put "/user/update", to: "user#update"
  get "/user/show", to: "user#show"
  get "/user/mostpopular",to: "user#most_popular"

  get "/article", to:"article#home"
  get "/article/show", to:"article#show"
  post "/article/create", to:"article#create"
  put "/article/edit", to:"article#update"
  delete "/article/delete", to: "article#delete"
  get "/article/mostLiked", to: "article#most_liked"
  get "/article/mostCommented", to: "article#most_commented"

  post "/like", to: "like#home"

  post "/comment", to: "comment#create"
  delete "/uncomment", to: "comment#delete"

  get "/category", to: "category#show"

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
