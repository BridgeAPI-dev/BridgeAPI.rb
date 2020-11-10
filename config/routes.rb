Rails.application.routes.draw do
  resources :bridges do 
    resources :environment_variables
    resources :headers
  end
end
