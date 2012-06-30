ShiaMe::Application.routes.draw do
    root to: 'pages#home'
      
   resources :subscribers
   
   controller :admin_session do 
     get 'admin_login' => :new
     post 'admin_login' => :create
     delete 'admin_logout' => :destroy
   end
  
      
   match "/about", to: 'pages#about'
   match "/thankyou", to: 'subscribers#thankyou'

end
