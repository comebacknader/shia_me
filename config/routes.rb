ShiaMe::Application.routes.draw do


   root to: 'pages#home'
    
   resources :admins       
   resources :subscribers
   resources :admin_sessions, only: [:new, :create, :destroy]
   resources :usersessions, only: [:new, :create, :destroy]
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
       get 'pics'
       put 'picsupdate'
     end
   end
   
   resources :users do 
     member do 
       get 'profile'
       get 'pics'
       put 'picsupdate'
       get 'assign'
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
   match '/signin', to: 'usersessions#new'
   match '/signout', to: 'usersessions#destroy', via: :delete
   
end
