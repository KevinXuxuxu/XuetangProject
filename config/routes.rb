Xuetang::Application.routes.draw do

<<<<<<< HEAD
  resources :messages

=======
<<<<<<< HEAD
  resources :messages
=======
<<<<<<< HEAD
  resources :courses
=======
>>>>>>> 91a88e822bd77273d1b2abb8e5eb97c587c5f14a
  resources :comments

  resources :topics

  resources :posts
<<<<<<< HEAD
=======
>>>>>>> 6b2895e06d1945cf04888ba161930b7743ef9af9
>>>>>>> 31b948ca37b216a6c05883eb2b48917f78ca9307
>>>>>>> 91a88e822bd77273d1b2abb8e5eb97c587c5f14a

  root 'index#index'

  resources :users

  resources :categories

  resources :articles

<<<<<<< HEAD
  post '/' => 'index#index'
=======
  get 'login' => 'login#receive'

<<<<<<< HEAD
  get 'personal' => 'personal#index'

=======
>>>>>>> 6b2895e06d1945cf04888ba161930b7743ef9af9
>>>>>>> 31b948ca37b216a6c05883eb2b48917f78ca9307
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
