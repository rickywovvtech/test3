Rails.application.routes.draw do
  # resources :discussions
  root 'discussions#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      resources :discussions do
        collection do
          post 'user_post'
          post 'follow_user'
          get 'all_discussion'
          get 'my_post'
          post 'submit_comment'
        end 
      end
    end
  end

end
