Rails.application.routes.draw do

root :to => "pages#index"
resources :catalog, :only => [:index]

resources :paintings

get '/catalog/:painting_id/get_previews' => 'catalog#get_previews', :as => 'get_previews'

get 'show_all' => 'paintings#show_all'

match 'contacts' => 'pages#contacts', :via => :get
match 'about' => 'pages#about', :via => :get

namespace 'admin' do
  get '/' => 'dashboard#index'

  resources :galleries
  resources :paintings do
    resources :previews
  end

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
