# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN
  resources :posts do
    scope module: :posts do
      resources :comments, only: %i[create]
    end
  end
  resources :posts, shallow: true do
    scope module: :posts do
      resources :comments, only: %i[edit update destroy]
    end
  end
  # END
end
