Rails.application.routes.draw do

  devise_for :users
  root to: "home#index"
  resources :users 
  resources :tweets do 
    resources :comments, only: :create
      collection do
        get 'search'
      end
    resource :likes, only: [:create, :destroy]
  end

end
