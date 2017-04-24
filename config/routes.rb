Rails.application.routes.draw do
  resources :svg_images
  resources :cargo
  resources :ships
  resources :people
  get 'welcome/index'
  authenticate :user do
    get '/dashboard', to: 'welcome#dashboard'
    post '/dashboard/new_color',
         to: 'welcome#new_color',
         as: :new_color
    #get '/launch/existing-or-new',
    #    to: 'welcome#existing_or_new',
    #    as: :begin_launch_wizard
    get '/launch/new-ship',
        to: 'welcome#new_ship_info',
        as: :launch_wizard_new_ship_info
    get '/launch/new-ship/picture',
        to: 'welcome#new_ship_picture',
        as: :launch_wizard_new_ship_picture
    post '/launch/new-ship/picture',
         to: 'welcome#set_new_ship_picture',
         as: :launch_wizard_set_new_ship_picture
    get '/launch/new-ship/summary',
        to: 'welcome#new_ship_summary',
        as: :launch_wizard_new_ship_done

    get '/launch/radar',
        to: 'welcome#radar',
        as: :radar
  end

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
