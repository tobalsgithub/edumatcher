Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # get '/', to: redirect('/')

  get 'welcome/proxy_test' => 'welcome#proxy_test'

  # routes for users
  post 'users/set_expert' => 'users#set_expert'
  post 'users/set_educator' => 'users#set_educator'


  # routes for experts

  resources :experts do
    # get 'subjects' => 'experts#subjects'
    # put 'add_subject' => 'experts#add_subject'
    # put 'remove_subject' => 'experts#remove_subject'
    # post 'set_subjects' => 'experts#set_subjects'
  end
  get 'experts/:id/subjects' => 'experts#subjects'
  post 'experts/add_subject' => 'experts#add_subject'
  post 'experts/remove_subject' => 'experts#remove_subject'
  post 'experts/set_subjects' => 'experts#set_subjects'
  get 'experts/search' => 'experts#search'


  # routes for educators
  resources :educators
  get 'educators/:id/subjects' => 'educators#subjects'

  # routes for classrooms
  resources :classrooms
  get 'classrooms/:id/subjects' => 'classrooms#subjects'
  put 'classrooms/:id/add_subject' => 'classrooms#add_subject'
  put 'classrooms/:id/remove_subject' => 'classrooms#remove_subject'
  post 'classrooms/:id/set_subjects' => 'classrooms#set_subjects'
  get 'classrooms/search' => 'classrooms#search'

  # routes for schools
  resources :schools

  # routes for school_districts
  resources :school_districts

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
