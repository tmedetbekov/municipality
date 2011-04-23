Monica::Application.routes.draw do

  resources :articles

  root :to => "homes#index"
  resources :reports
  match "about" => "articles#about"
  match "contacts" => "articles#contact"
  
  resources :reports do
    member do
      post :vote_up
    end
  end
  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions'}
  match "/auth/:provider/callback" => "authentications#create"

end
