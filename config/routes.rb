Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'dashboard#index', id: 'index'

  get 'dashboard/index', to: 'dashboard#index'
end
