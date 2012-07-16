ShiaMe::Application.routes.draw do

   root to: 'pages#home'
    
   resources :admins    
   resources :subscribers
  
      
   match "/about", to: 'pages#about'
   match "/thankyou", to: 'subscribers#thankyou'
   match "/signup", to: 'admins#new'

end
