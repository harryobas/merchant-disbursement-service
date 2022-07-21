Rails.application.routes.draw do

  resources :disbursements, only: [:index] do
    collection do 
      get :search
    end
  end
   
end
