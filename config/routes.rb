Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    resources :cards, shallow: true, only: [:create, :edit, :destroy, :update] do
    	collection { post :sort }
    end
  end

  root 'welcome#index'

end