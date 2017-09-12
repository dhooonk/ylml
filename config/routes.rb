Rails.application.routes.draw do

    devise_for :users, :skip => [:registrations, :passwords], controllers: {
        sessions: 'users/sessions'
      }
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users' => 'devise/registrations#update', :as => 'user_registration'
    end

    root "posts#index"
    get "/posts/privacy" =>"posts#privacy"
    get "/posts/partner" =>"posts#partner"
    resources :posts, only: [:index, :new]
    resources :box, only: [:index, :create]
    get "/box/index" =>"box#index"
    get "/box/applsci" =>"box#applsci"
    get "/box/ime" =>"box#ime"
    get "/box/eni" =>"box#eni"
    delete "/box/destroy_apli_chem/:id" => "box#destroy_apli_chem"
    delete "/box/destroy_apli_sci/:id" =>"box#destroy_apli_sci"
    delete "/box/destroy_ime/:id" =>"box#destroy_ime"
    delete "/box/destroy_eni/:id" =>"box#destroy_eni"
    resources :admin, only: [:index, :destroy, :edit]
    delete "/destroy_all/:id" => "admin#destroy_all"
    post "/admin/:id" => "admin#feeOfSch"
    resources :choose, only: [:index]
    get '/tempusers/new' => 'tempusers#new'
    get '/tempusers/select' => 'tempusers#select'
    post '/tempusers/accept' => 'tempusers#accept'
    post '/tempusers/create' => 'tempusers#create'
    get '/tempusers/index' => 'tempusers#index'
    get '/tempusers/indexE' => 'tempusers#indexE'
    delete '/tempusers/destroy' => 'tempusers#destroy'

    resources :csv, only: [:index, :create] do
      collection { post :import }
    end
  resources :limits, only: [:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    match '*path' => redirect('/'), via: :get
    get '/rails/info/routes' => redirect('/')
end
