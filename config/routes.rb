# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :all

  devise_scope :user do
    get "signin", to: "devise/sessions#new"
    post "signin", to: "devise/sessions#create"
    delete "signout", to: "devise/sessions#destroy"
    get "signup", to: "devise/registrations#new"
    post "signup", to: "devise/registrations#create"
  end

  get "/@:username", to: "users#show", constraints: { username: /[a-zA-Z0-9]+/ }, as: "user"
  get "/@:username/events/:id", to: "events#show", as: "user_event"
  get "/@:username/events/:id/edit", to: "events#edit", as: "edit_user_event"
  patch "/@:username/events/:id/edit", to: "events#update"
  put "/@:username/events/:id/edit", to: "events#update"
  post "/@:username/events/:id/attend_event", to: "event_attendings#create", as: "attend_event"
  delete "/@:username/events/:id/leave_event", to: "event_attendings#destroy", as: "leave_event"
  delete "/@:username/events/:id/kick_user", to: "event_attendings#destroy", as: "kick_user"
  delete "/@:username/events/:id/delete", to: "events#destroy", as: "delete_event"

  resources :events, only: %i[new create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "events#index"
end
