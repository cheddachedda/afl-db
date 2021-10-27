Rails.application.routes.draw do
  root :to => 'pages#home'
  resources :clubs
end
