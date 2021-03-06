SrsCollector::Application.routes.draw do
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      post "sessions/create(.:format)", defaults: { format: 'json' }
      post "sessions/destroy(.:format)", defaults: { format: 'json' }

      resources :users do
        collection do
          post :api_key
        end
      end
      resources :cards do
        collection do
          get :stats
          post :mark_reviewed_as_exported
        end
      end
      resources :playable_media do
        resources :subtitles
      end
      resources :card_models
      resources :dictionaries
      resources :languages do
        collection do
          post :translate
        end
      end
    end
  end

  StaticController::PAGES.each do |page|
    next if page == "index"
    get page => "static##{page}"
  end

  root "static#index"

  # Wildcard routes: All non-API paths just serve up our app.
  get "/api/*path", to: proc { [404, {}, ['']] }
  get "/*path" => "static#index"

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
