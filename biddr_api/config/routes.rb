Rails.application.routes.draw do

  # The namespace method in Rails routes makes it so it will automatically look in a directory api, then in a subdirectory v1 for QuestionsController.  
  namespace :api, defaults: { format: :json } do
    # /api..
    namespace :v1 do
      # /api/v1...
      resources :auctions do
        resources :bids, only: [:create, :destroy, :index, :show]
        resources :publishings, only: :create
        resources :reservings, only: :create
      end
      # /api/v1/auctions
      resource :session, only: [:create, :destroy]
      # /api/v1/users
      resources :users, shallow: true, only: [:create, :new, :show, :index] do
      # api/v1/users/current
        get :current, on: :collection
        # default
        # api/v1/user/:id/current
      end
    end
  end
end