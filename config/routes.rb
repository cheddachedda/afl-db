Rails.application.routes.draw do
  root :to => 'pages#home'
  resources :clubs, :only => [ :index, :show ]
  resources :players

  get '/fixtures' => 'fixtures#index'
  get '/fixtures/:round' => 'fixtures#round', as: 'round'
  get '/fixtures/:round/:id' => 'fixtures#show', as: 'fixture'

end
