Rails.application.routes.draw do
  root to: "pages#home"

  resources :offers do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :edit, :update]

  devise_for :users
  resources :users, only: %i[show]
end
