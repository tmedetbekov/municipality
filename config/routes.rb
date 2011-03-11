Monica::Application.routes.draw do

  root :to => "homes#index"
  get "homes/admin"


  resources :reports do
    member do
      post :vote_up
    end
  end

  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions'}

  match "/auth/:provider/callback" => "authentications#create"

end
