Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  root to: 'user/homes#top'


  scope module: :user do
    get 'reviews/search' => 'reviews#search'
    get 'reviews/bookmarks' => 'users#bookmarks'
    resources :reviews do
      resources :review_comments, only: [:create, :destroy]
      resources :bookmarks, only: [:create, :destroy]
    end
    get 'users/quit' => 'users#quit'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]do
      get :bookmarks, on: :member
    end
  end

  namespace :admin do
    get 'homes/top'
    get 'reviews/search' => 'reviews#search'
    resources :users, only: [:index, :show, :edit, :update]
    resources :origins, only: [:index, :create, :edit, :update, :destroy]
    resources :types, only: [:index, :create, :edit, :update, :destroy]
    resources :brands, only: [:index, :create, :edit, :update, :destroy]
    resources :products, only: [:index, :create, :edit, :update, :destroy]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy] do
      resources :review_comments, only: [:destroy]
    end
  end


  # scope module: :user do
  #   get 'users/quit' => 'users#quit'
  #   patch 'users/withdraw' => 'users#withdraw'
  #   resources :users, only: [:show, :edit, :update]do
  #     get :bookmarks, on: :member
  #   end
  # end

   # ゲストユーザー用のルーティング
  devise_scope :user do
    post "user/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

end
