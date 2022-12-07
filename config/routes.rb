Rails.application.routes.draw do
   root "pages#home"
   get 'about', to:'pages#about'
   #there will be many routes associated with a databse item inorder to perform crud operatios..hence rails provides us with a useful feature to include all such routes 

   resources :articles
   get 'signup' , to:'users#new'
   resources :users , except: [:new]
end
