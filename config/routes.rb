Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'messages#index' 

  get    'login'   => 'logins#new'
  post   'login'   => 'logins#create'
  delete 'logout'  => 'logins#destroy'
  
  get 'signup'  => 'authors#new'

  resources :authors do 
    member do 
      post 'follow'
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources :messages do 
    collection do 
      get 'streams/:stream', :action => :streams, :as => "streams"
    end
    member do 
      post 'favourite'
    end
  end
  
  get "images/fivestar"
  get "images/find"
  resources :images
 
  resources :users
  get 'home' => 'static_pages#home'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#auth_fail'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  
  resources :comments, only: [:new, :create, :show, :destroy] do 
    member do 
      post 'vote'
    end
  end
 


end
