Rails.application.routes.draw do
  # get 'offers/index'
  # get 'offers/show'
  # get 'offers/new'
  # get 'offers/create'
  # get 'offers/edit'
  # get 'offers/update'
  # get 'offers/destroy'

  root to: "pages#home"

  resources :offers, only: [:index, :show, :edit]

  resources :offers do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :edit, :update]

  devise_for :users

end
