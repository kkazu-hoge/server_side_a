Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :ver1 do
      resources :items, only: [:index, :create]
    end
  end

end
