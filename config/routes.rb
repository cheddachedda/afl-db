Rails.application.routes.draw do
  root :to => 'pages#home'
  resources :clubs, :only => [ :index, :show ]
  resources :fixtures
end
