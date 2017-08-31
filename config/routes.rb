Rails.application.routes.draw do
    devise_for :users, :skip => [:registrations]
      as :user do
        get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
        put 'users' => 'devise/registrations#update', :as => 'user_registration'
      end
    root "posts#index"
    resources :posts, only: [:index, :new]
    resources :box, only: [:index, :create, :destroy]
    get "/box/index" =>"box#index"
    get "/box/applsci" =>"box#applsci"
    get "/box/ime" =>"box#ime"
    delete "/box/destroy_apli_chem/:id" => "box#destroy_apli_chem"
    delete "/box/destroy_apli_sci/:id" =>"box#destroy_apli_sci"
    delete "/box/destroy_ime/:id" =>"box#destroy_ime"
    resources :admin, only: [:index, :destroy, :edit]
    delete "/destroy_all/:id" => "admin#destroy_all"
    resources :choose, only: [:index]
    get '/tempusers/new' => 'tempusers#new'
    post '/tempusers/create' => 'tempusers#create'
    get '/tempusers/index' => 'tempusers#index'
    get '/tempusers/indexE' => 'tempusers#indexE'
    resources :csv, only: [:index, :create] do
      collection { post :import }
    end
  resources :limits, only: [:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
