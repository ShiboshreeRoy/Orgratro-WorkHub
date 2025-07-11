Rails.application.routes.draw do
 
  get "user_dashbord/index"
  resources :withdrawals
  resources :clicks

  resources :links 
  post "click_link/:id", to: "clicks#create", as: "click_link"
  #post 'claim_reward/:id', to: 'links#claim_reward', as: :claim_reward



  
  devise_for :users
  
  resources :admin , only: [:index, :create, :edit, :update, :show, :destory], controller: 'admin'
  resources :admin_dashbord, only: [:index]

 resources :welcome do
  collection do
    get :about
    get :service
    get :contact_us
  end
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
   root "welcome#index"
end
