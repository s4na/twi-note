# frozen_string_literal: true

Rails.application.routes.draw do
  root "notes#index"
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks', only: %i(post)
  }
  
  resources :notes
  namespace "api" do
    resources :tweets, only: %i(index)
  end
end
