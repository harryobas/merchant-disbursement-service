Rails.application.routes.draw do

  resources :merchants, only: [:index] do
    member do
      post :disburse
    end
  end

  resources :disbursements, only: [:index] do
    collection do 
      get :search
    end
  end
   
end
