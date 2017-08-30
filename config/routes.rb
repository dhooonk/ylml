Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :posts, only: [:index, :new]
  resources :box, only: [:index, :create, :destroy]
  get "/box/index" =>"box#index"
  get "/box/applsci" =>"box#applsci"
  get "/box/ime" =>"box#ime"
  resources :admin, only: [:index, :destroy, :edit]
  delete "/destroy_all/:id" => "admin#destroy_all"
  resources :choose, only: [:index]
  resources :csv, only: [:index, :create] do
   collection { post :import }
  end
  resources :limits, only: [:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
