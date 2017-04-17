Rails.application.routes.draw do
  resources :cargo
  resources :ships
  resources :people
  get 'welcome/index'
  authenticate :user do
    get '/dashboard', to: 'welcome#dashboard'
    get '/launch/existing-or-new',
        to: 'welcome#existing_or_new',
        as: :begin_launch_wizard
    get '/launch/new-ship',
        to: 'welcome#new_ship_info',
        as: :launch_wizard_new_ship_info
    get '/launch/new-ship/:ship_id/picture',
        to: 'welcome#new_ship_picture',
        as: :launch_wizard_new_ship_picture
  end

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
