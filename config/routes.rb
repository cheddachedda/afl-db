Rails.application.routes.draw do
  root :to => 'pages#home'
  resources :clubs, :only => [ :index, :show ]
  get '/fixtures' => 'fixtures#index'
  get '/fixtures/:round' => 'fixtures#round', as: 'round'
end
