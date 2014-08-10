Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # get '/', to: redirect('/')

  get 'welcome/proxy_test' => 'welcome#proxy_test'

  # routes for classrooms
  get 'classrooms/search' => 'classrooms#search', :defaults => {:format => "json"}
  resources :classrooms, :defaults => {:format => "json"}
  get 'classrooms/:id/subjects' => 'classrooms#subjects', :defaults => {:format => "json"}
  put 'classrooms/:id/add_subject' => 'classrooms#add_subject', :defaults => {:format => "json"}
  put 'classrooms/:id/remove_subject' => 'classrooms#remove_subject', :defaults => {:format => "json"}
  post 'classrooms/:id/set_subjects' => 'classrooms#set_subjects', :defaults => {:format => "json"}

  # routes for companies
  get 'companies/search' => 'companies#search', :defaults => {:format => "json"}
  resources :companies, :defaults => {:format => "json"}

  # routes for educators
  resources :educators, :defaults => {:format => "json"}
  get 'educators/:id/subjects' => 'educators#subjects', :defaults => {:format => "json"}

  # routes for employment_links
  resources :employment_links, :defaults => {:format => "json" }

  # routes for experts
  get 'experts/search' => 'experts#search', :defaults => {:format => "json"}
  resources :experts, :defaults => {:format => "json"}
  get 'experts/:id/subjects' => 'experts#subjects', :defaults => {:format => "json"}
  put 'experts/:id/add_subject' => 'experts#add_subject', :defaults => {:format => "json"}
  put 'experts/:id/remove_subject' => 'experts#remove_subject', :defaults => {:format => "json"}
  post 'experts/:id/set_subjects' => 'experts#set_subjects', :defaults => {:format => "json"}
  get 'experts/:id/company' => 'experts#company', :defaults => {:format => "json"}
  put 'experts/:id/add_company' => 'experts#add_company', :defaults => {:format => "json"}
  put 'experts/:id/remove_company' => 'experts#remove_company', :defaults => {:format => "json"}
  post 'experts/:id/set_companies' => 'experts#set_companies', :defaults => {:format => "json"}

  # routes for knowledge_links
  resources :knowledge_links, :defaults => {:format => "json" }

  # routes for reviews
  resources :reviews, :defaults => {:format => "json" }

  # routes for schools
  resources :schools, :defaults => {:format => "json"}
  get 'schools/:id/classrooms' => 'schools#classrooms', :defaults => {:format => "json"}

  # routes for school_districts
  resources :school_districts, :defaults => {:format => "json"}
  get 'school_districts/:id/schools' => 'school_districts#schools', :defaults => {:format => "json"}

  # routes for subjects
  resources :subjects, :defaults => {:format => "json"}

  #routes for grade_levels
  get 'grade_levels' => 'grade_levels#index', :defaults => {:format => "json" }

  # routes for users
  post 'users/:id/set_expert' => 'users#set_expert', :defaults => {:format => "json"}
  post 'users/:id/set_educator' => 'users#set_educator', :defaults => {:format => "json"}

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
