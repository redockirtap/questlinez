# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true, except: %i[index new] do
      member { patch :choose_best }
    end
  end
end
