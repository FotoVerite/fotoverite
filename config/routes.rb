Rails.application.routes.draw do
  resources :users

 # if Rails.env.development?
 #    mount MailPreview => 'mail_view'
 #  end

  root :to => 'portfolios#index'
  resources :sets, :controller => :portfolios

  namespace :staff do

    root :to => "access#menu"
    get "/login" => "access#new"
    delete "/logout" => "access#destroy"

    resource :access, :controller => "access", :except => [:edit, :update] do
      member do
        get :get_password_idea
        get :menu
        get :forgot_password
        put :send_new_password
      end
    end

    resources :admins do
      member do
        get :delete
      end
    end
    resources :portfolios do
      resources :photos
    end

  end
end
