# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "notes#index"
  resources :notes
  namespace "api" do
    resources :tweets, only: %i(index)
  end
end
