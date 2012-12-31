ShiaMe::Application.routes.draw do


   root to: 'pages#home'
    
   resources :admins       
   resources :subscribers
   resources :admin_sessions, only: [:new, :create, :destroy]
   resources :usersessions, only: [:new, :create, :destroy]
   resources :invites
   resources :users
   resources :matches
   resources :messages
   resources :msgs
   resources :questions
   resources :mquests
   resources :subscriptions
   resources :feeds

   
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
       get 'sendmsg'
       get 'showmsg'
       get 'crop' 
       put 'cropupdate'
     end     
   end

   
   resources :users do 
     member do      
       get 'profile'
       get 'pics'
       put 'picsupdate'
       get 'assign'
       put 'assignmm'
       get 'match'
       post 'makematch'
       get 'deletematch'
       get 'crop'
       put 'cropupdate'
       get 'permission'
       put 'gotpermit'  
       get 'pick'
       put 'pickmm'     
      end
    end
    
    resources :users do 
    	resources :matches
    	resources :messages
    	resources :msgs
    	resources :questions
    	resources :mquests
    	resources :subscriptions
	end
	
	resources :messages do 
		resources :questions
		end

	
	resources :admins do 
		resources :msgs
    resources :feeds
	end
    	
    resources :matches do 
     member do
     	put 'approvefem'
        put 'approveinfo'
        put 'approvepic'
     end
    end	
    
    resources :msgs do 
      member do 
        put 'adminhide'
        put 'userhide'
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
   match '/sent', to: 'messages#sent'
   match '/allbox', to: 'messages#allbox'

   
end
