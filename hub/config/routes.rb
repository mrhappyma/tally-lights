Rails.application.routes.draw do
  get "/" => "static_pages#index"
  get "/switcher-simulator" => "static_pages#switcher_simulator"

  resources "tallies" do
    member do
      post :switch
    end

    collection do
      get :on
    end
  end

  resources "inputs" do
    member do
      post :set_status
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
