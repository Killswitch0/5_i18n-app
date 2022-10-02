Rails.application.routes.draw do
  resources :users

  # scope задает префикс именованных маршрутных хелперов, который включает нужную нам локализацию
  # например 127.0.0.1:3000/ru/users или 127.0.0.1:3000/en/users
  scope ('/:locale'), locale: /en|ru/ do
    root 'welcome#index'

    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
