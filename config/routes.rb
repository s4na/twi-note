# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "notes#index"
  resources :privacy_policies, only: %i(index)
  resources :disclaimers, only: %i(index)

  namespace "api" do
    resources :tweets, only: %i(index)
  end

  devise_for :users, only: [:sessions, :omniauth_callbacks], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks", only: %i(post)
  }

  resources "users" do
    resources "followings", only: %i(index), controller: "users/followings"
    resources "followers", only: %i(index), controller: "users/followers"
    resources "notes", only: %i(index), controller: "users/notes"
  end

  namespace "notes" do
    resources :download, only: %i(show)
  end

  namespace "followings" do
    resources "notes", only: %i(index)
  end

  resources :users, only: %i(index show)
  resources :notes
  resources :follows, only: %i(create destroy)
end
