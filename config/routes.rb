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
   resources :mmsgs
   resources :admin_resets
   resources :password_resets

   
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
       get 'deleteusers'
       get 'sentmmsgs'
       get 'desiwomen'
       get 'desimen'
       get 'persianmen'
       get 'persianwomen'
       get 'othermen'
       get 'otherwomen'
       get 'arabmen'
       get 'arabwomen'
       get 'othermen'
       get 'otherwomen'
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
    resources :mmsgs
	end
    	
    resources :matches do 
     member do
     	put 'approvefem'
        put 'approveinfo'
        put 'approvepic'
        get 'deletematch'        
     end
    end	
    
    resources :msgs do 
      member do 
        put 'adminhide'
        put 'userhide'
        get 'replymsg'
      end
    end

    resources :mmsgs do 
      member do 
        put 'adminhide'
        get 'sentmmsg'
        put 'senthide'         
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
   match '/adminreset', to: 'admin_resets#adminreset'
   match '/userreset', to: 'password_resets#userreset'
   match '/freeuser', to: 'users#freeuser'

   
end
