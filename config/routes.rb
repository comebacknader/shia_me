ShiaMe::Application.routes.draw do

   root to: 'pages#home'
    
   resources :admins    
   resources :subscribers
   resources :admin_sessions, only: [:new, :create, :destroy]
  
      
   match "/about", to: 'pages#about'
   match "/thankyou", to: 'subscribers#thankyou'
   match "/oldbrowser", to: 'pages#oldbrowser'
   match '/login', to: 'admin_sessions#new'
   match '/logout', to: 'admin_sessions#destroy', via: :delete
  
   
end
