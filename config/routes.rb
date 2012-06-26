ShiaMe::Application.routes.draw do
   root to: 'pages#home'
   
   
   match "/about", to: 'pages#about'
   match "/signup", to: 'subscribers#new'

end
