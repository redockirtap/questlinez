# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :attachments, shallow: true, only: :destroy

    resources :answers, shallow: true, except: %i[index new] do
      resources :attachments, shallow: true, only: :destroy
      member { patch :choose_best }
    end
  end
end
