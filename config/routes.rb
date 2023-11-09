Rails.application.routes.draw do
  
  root to: 'user/homes#top'  
  
  namespace :user do
    get 'users/mypage' => 'users#show'
    get 'users/quit' => 'users#quit'
    patch 'users/withdraw' => 'users#withdraw'    
    resources :users, only: [:edit, :update]  
    resources :reviews  
  end
  
  namespace :user do
    get 'users/mypage' => 'users#show'
    get 'users/quit' => 'users#quit'
    patch 'users/withdraw' => 'users#withdraw'    
    resources :users, only: [:edit, :update]  
    resources :reviews  
  end
  
  namespace :admin do
    get 'homes/top'
  end
  
  namespace :admin do
    resources :origins, only: [:index, :create, :edit, :update, :destroy]
  end
  
  namespace :admin do
    resources :types, only: [:index, :create, :edit, :update, :destroy]   
  end
  
  namespace :admin do
    resources :brands, only: [:index, :create, :edit, :update, :destroy]   
  end
  
  namespace :admin do
    resources :products, only: [:index, :create, :edit, :update, :destroy]     
  end

  namespace :admin do
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]       
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/edit'
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]     
  end
    
  
  
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }  
  
end
