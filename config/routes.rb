Rails.application.routes.draw do
  
  resources :advertisements
  resources :questions
  
  # called 'resources' method and pass a 'Symbol'
  # it let Rails to create post routes for creating , updating, viewing, and deleting an instances of 'Post'
  resources :topics do
    # pass 'resources :posts' to the 'resources :topics' block, to nests the post routes under the topic routes
    # doesn't have an 'index' route for posts any more. All posts will show on a toipc show view
    resources :posts, except: [:index]
    resources :sponsoredposts
  end
  
  # create routes for 'new' and create actions
  # the 'only' hash key will prevent Rails from creating unnecessary routes
  resources :users, only: [:new, :create]
  
  # add the routes for sessions' ':new', ':creat' and ':destroy' method
  # need to run 'rake routes | grep session' to check
  resources :sessions, only: [:new, :create, :destroy]
  
  post 'users/confirm' => 'users#confirm'
  
  # create HTTP 'GET' routes for index and about views
  # had remove 'get "welcome/index"' because we have declared the index view as the root view.
  # also modity the 'about' route to allow user to visit '/about', rather than '/welcome/about'
  get 'about' => 'welcome#about'
  get 'faq' => 'welcome#faq'
  
  
  # root method allows us to declare the view on default page for home page URL
  # root takes a hash as an argument, the line is same as 'root ({to: 'welcome#index'})
  # use "implied hash" (root 'welcome#index') is enhancing read ability
  # can use 'rake routes' to see all available routes for this app
  root 'welcome#index'
  
end
