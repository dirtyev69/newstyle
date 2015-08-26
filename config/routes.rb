Rails.application.routes.draw do

root :to => "pages#index"
resources :galleries, :only => [:index]
resources :paintings

match 'contacts' => 'pages#contacts', :via => :get
match 'about' => 'pages#about', :via => :get

namespace 'admin' do
  get '/' => 'dashboard#index'

  resources :galleries
  resources :paintings
  resources :images, :only => [:create, :update, :destroy]

  namespace 'auth' do
    get 'sign_up' => 'users#new'
    post 'sign_up' => 'users#create'

    get 'sign_in' => 'sessions#new'
    post 'sign_in' => 'sessions#create'

    get 'sign_out' => 'sessions#destroy'
    end
  end
end
