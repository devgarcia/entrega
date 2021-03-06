Rails.application.routes.draw do

  post "epayco/response", to: "epayco#result" # You MUST change the METHOD to Post if external: true on epayco.html.erb
  post "epayco/confirmation", to: "epayco#confirmation"


  
  get 'charges/index'

  
  #get 'charges/create'

#get '/:locale' => 'access#home' # from GUIDES # Commented for working with Admin
root 'access#home'



  #scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 

 # localized do
    #

  #scope "(:locale)", locale: /en|es/ do


    #localized do

      
   
       #get '/:locale' => 'access#home' # from GUIDES
       #root 'access#home'
       
       devise_for :admins

        
        #get 'access/home' COMMENTED OUT AS PER GUIDES
        
        devise_for :senders
        devise_for :companies
        #devise_for :transporters  

        devise_for :transporters, controllers: { sessions: 'transporters/sessions' }

        get 'locations/geocode'

#scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 

        resources :companies do
          resources :transporters do 
            member do
              get :orders
            end      
          end
          resources :orders do
            resources :recipients
              collection do
                get :posts
                get :taken
              end
              member do
                get :take
              end      
          end
        end

        resources :senders do
          resources :charges, only: [ :new, :create] 
          resources :orders do
            resources :recipients 
            collection do
              get :posts
              get :posted
            end      
          end
        end 

        resources :transporters do
          resources :orders 
        end

        #resources :orders do 
        #  resources :charges, only: [ :new, :create]
        #end
   # end
    
  #end

 # get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
 # get '', to: redirect("/#{I18n.default_locale}/%{path}")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
