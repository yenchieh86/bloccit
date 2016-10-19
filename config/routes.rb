Rails.application.routes.draw do
  # create HTTP 'GET' routes for index and about views
  get 'welcome/index'
  get 'welcome/about'
  
  # root method allows us to declare the view on default page for home page URL
  # root takes a hash as an argument, the line is same as 'root ({to: 'welcome#index'})
  # use "implied hash" (root 'welcome#index') is enhancing readability
  # can use 'rake routes' to see all available routes for this app
  root 'welcome#index'
  
end
