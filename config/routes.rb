ShiaMe::Application.routes.draw do

  get "invites/new"

   root to: 'pages#home'
    
   resources :admins       
   resources :subscribers
   resources :admin_sessions, only: [:new, :create, :destroy]
   resources :invites
   resources :users
   
   scope :admins do 
     resources :admins, :path => "matchmakers"
   end
  
   resources :admins do 
     member do 
       get 'profile'
       get 'allmen'
       get 'allwomen'
       get 'allmatches'
     end
   end
      
   match "/about", to: 'pages#about'
   match "/thankyou", to: 'subscribers#thankyou'
   match "/oldbrowser", to: 'pages#oldbrowser'
   match '/login', to: 'admin_sessions#new'
   match '/logout', to: 'admin_sessions#destroy', via: :delete
   match '/signup', to: 'users#new'
   match '/invite', to: 'pages#invite'
   match '/test', to: 'pages#test'
   
   
end
