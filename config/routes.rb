Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
   
   post 'users/:id/unfriend', to: 'users#unfriend', as: 'unfriend'
   post 'users/:id/friend', to: 'users#friend', as: 'follow'
   post 'users/:id/accept', to: 'users#accept', as: 'accept'
   post 'users/:id/decline', to: 'users#decline', as: 'decline'
   post 'users/:id/cancel', to: 'users#cancel', as: 'cancel'
   
   get '/pages/friends'
   get 'users/:id', to: 'users#show', as: 'users'
   resources :pages
   resources :users
  
   root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
