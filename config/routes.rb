Rails.application.routes.draw do
  root to: "pages#home"

  resources :offers do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[index show edit update] do
    member do
      patch :accept
      patch :refuse
      patch :cancel
    end
  end

  devise_for :users
  resources :users, only: %i[show]
end
