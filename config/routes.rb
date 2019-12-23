Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'application#index'
  devise_for :users#, :skip => :registrations
  
  resources :restaurants do
    
    resources :branches do
      resources :orders do
        resources :order_lines
      end
    end
  end
  get 'restaurant/:city', to: 'restaurants#by_city', as: "by_city"

  # devise_for :admins, class_name: 'Admin', skip: [:sessions, :registrations]
  # devise_for :vendors, class_name: 'Vendor', skip: :sessions
  # devise_for :customers, class_name: 'Customer', skip: :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
