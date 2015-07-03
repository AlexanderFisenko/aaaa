Rails.application.routes.draw do

  namespace :api do
    resources :group_events
  end

end
