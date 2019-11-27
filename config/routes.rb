Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
  	resources :surveys, except: [ :show, :edit, :update, :delete]
  end
  resources :surveys, only: [ :show ] do
    resources :survey_questions, only: [:create, :update]
  end

  resources :survey_questions, except: [ :update, :delete, :create] do
  	resources :question_answers, except: [:edit, :update, :delete]
  end

  resources :participants, except: [:edit, :update, :delete]
end
