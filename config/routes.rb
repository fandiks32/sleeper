Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'clock_in_out/clock_in', to:  'clock_in_out#clock_in'
  post 'clock_in_out/clock_out', to: 'clock_in_out#clock_out'
  get 'clock_in_out/index', to: 'clock_in_out#index'

  resources :follow do
    collection do
      post :unfollow
    end
  end

  resources :user
end
