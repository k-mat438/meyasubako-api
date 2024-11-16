# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    # 'User':認証対象のモデル名
    # at: 'auth' :認証関連のエンドポイントのベース ex.) v1/auth/~~~

    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      # defaultはdevise_token_authのregistrationコントローラ
      registrations: 'v1/auth/registrations', # User登録コントローラ
      sessions: 'v1/auth/sessions', # sessionコントローラ
      passwords: 'v1/auth/passwords',
      token_validations: 'v1/auth/token_validations'
    } # , skip: [:sessions]

    # devise_scope :user do
    #   post 'auth/sign_in', to: 'auth/sessions#create'
    #   delete 'auth/sign_out', to: 'auth/sessions#destroy'
    # end
    resources :posts, only: %w[index create]
    resources :departments, only: %w[index create]
    resources :businesses, only: %w[index create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
