# frozen_string_literal: true

Rails.application.routes.draw do
  resources :notes
  namespace "api" do
    resources :tweets, only: %i(index)
  end
end
