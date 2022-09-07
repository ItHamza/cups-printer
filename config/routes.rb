Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'printers', to: 'printers#index'
  post 'print', to: 'printers#print'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'printer_settings', to: 'printer_settings#index'
end
