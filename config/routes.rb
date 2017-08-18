Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
as :user do
  get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  put 'users' => 'devise/registrations#update', :as => 'user_registration'
end
  root "posts#index"
  resources :posts, only: [:index, :new]
  resources :box, only: [:index, :create, :destroy]
  resources :admin, only: [:index, :destroy, :edit]
  delete "/destroy_all/:id" => "admin#destroy_all"
  get "adminbox" => "admin#adminbox"
  resources :csv, only: [:index, :create] do
   collection { post :import }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
