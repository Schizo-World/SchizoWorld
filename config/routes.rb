Schizoworld::Application.routes.draw do

  resources :announces
  resources :messages

  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil

  resource :session, :only => [:new, :create, :destroy, :provider, :failure]
  resources :sessions
  resources :users
  resources :projects do
    resources :posts
  end
  
  resources :videos do
  member do
    post :add_comment
  end
  new do
     post :upload
     get :save_video
   end
  end

  match "videos/:id/add_comment", :to => "videos#add_comment"

  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'signup' => 'users#new', :as => :signup
  match 'register' => 'users#create', :as => :register

  match '/auth/:provider/callback', :to => 'sessions#provider'
  match '/auth/failure', :to => 'sessions#failure'

  match 'profile' => 'users#index', :as => :profile

  match '/messages' => 'messages#create', :via => :post
  match '/messages', :to => 'messages#inbox'
  get 'messages/autocomplete_user_login'
  match '/messages/show/:id', :to => 'messages#show'
  match '/messages/inbox', :to => 'messages#inbox'
  match '/messages/sentbox', :to => 'messages#sentbox'
  match '/messages/trash', :to => 'messages#trash'
  match '/messages/new', :to => 'messages#new'
  
  #project
  match ':controller(/:action(/:id(.:format)))'
  
  # Root
  root :to => "application#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
