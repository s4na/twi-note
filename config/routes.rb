# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "notes#index"

  devise_for :users, only: [:sessions, :omniauth_callbacks], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks", only: %i(post)
  }

  namespace "notes" do
    resources :download, only: %i(show)
  end

  resources :notes
  resources :privacy_policies, only: %i(index)
  resources :disclaimers, only: %i(index)

  namespace "api" do
    resources :tweets, only: %i(index)
  end
end
