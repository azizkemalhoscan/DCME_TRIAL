Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
  	resources :surveys, except: [:edit, :update, :delete]
  end

  resources :survey_questions, except: [:edit, :update, :delete] do
  	resources :question_answers, except: [:edit, :update, :delete]
  end

  resources :participants, except: [:edit, :update, :delete]
end
