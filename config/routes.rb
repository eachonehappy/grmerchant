Rails.application.routes.draw do

  root to: 'pages#home'

  resources :recipes do
    collection do
      post :import
    end
  end
  resources :orders
  resources :recipes
  resources :merchants
  resources :customers
  resources :sms_messages
  resources :merchant_informations
  post 'add_wallet_money' => 'merchants#add_wallet_money'
  get 'cart'=> 'pages#cart'

  put 'add_to_cart' => 'recipes#add_to_cart'

  delete 'remove_cart_item' => 'recipes#remove_cart_item'
  delete 'delete_merchant' => 'merchants#destroy'

  post 'auto_complete' => 'orders#autocomplete'

  post 'new_new_order' => 'orders#new'
  get 'new_new_order' => 'customers#new'
  get 'my_orders' => 'pages#my_orders'

  post 'availability' => "recipes#availability"
  post 'shop_open' => "pages#shop_open"
  post 'cusine' => "pages#home"

  get 'closed_shop' => "pages#closed_shop"

  post 'sms_accept' => "pages#sms_accept"

  post 'send_sms' => "pages#send_sms"

  post 'accept_sms' => "pages#accept_sms"

  post 'reject_sms' => "pages#reject_sms"

  post 'order_delivery' => "orders#order_delivery"
  
  patch 'update_discount' => "pages#update_discount"
  patch 'update_pin' => "pages#update_pin"

  patch 'recipes' => "recipes#index"
  patch 'orders' => "orders#index"
  patch 'merchants' => "merchants#index"
  post 'set_sms' => "sms_messages#set_sms"
  post 'accept_merchant_information' => "merchant_informations#accept_merchant_information"
  devise_for :users, controllers: { sessions: 'users/sessions' ,:registrations => "users/registrations" }


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
