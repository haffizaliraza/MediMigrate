Rails.application.routes.draw do
  devise_for :users, path: 'auth',
    path_names: { sign_in: 'login', sign_out: 'logout' },
    :controllers => { :sessions => "users/sessions", registrations: 'users/registrations' }
  root "home#index"

  get 'checkout_success', to: 'home#checkout_success'

  resources :users do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  resources :courses do
    collection do
      post :checkout
    end
    member do
      post :toggle_cart
    end

    collection do
      get :for_student
    end
  end

  resources :jobs do
    member do
      patch :toggle_published
    end
    collection do
      get :for_student
    end
  end

  resources :job_applications do
    member do
      get :accept
      get :reject
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
