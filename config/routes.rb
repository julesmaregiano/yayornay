Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :polls, only: [:new, :index, :create, :show] do
    resources :messages, only: [:create]
    resources :targets, only: [:new, :create]
    resources :answers, only: [:new, :create]
    resources :favourites, only: [:create]
  end

  namespace :my do
    resources :polls, only: [:index, :show, :destroy]
  end

  get "fake-answers" => "pages#fake_answers"
  post "send-fake-answer" => "pages#send_fake_answer"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
