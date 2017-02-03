Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsoredposts
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :advertisements
  resources :questions

  post 'users/confirm' => 'users#confirm'
  get 'about' => 'welcome#about'
  get 'faq' => 'welcome#faq'
  root 'welcome#index'
end
