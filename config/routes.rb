Rails.application.routes.draw do

  namespace :api do
    resources :group_events, defaults: { format: 'json' }
  end

end
