Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    resources :events, only: [:index]
    resources :repos, shallow: true do
      resources :events
    end
  end
end
