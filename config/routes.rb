Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'pages/about_us', to: 'pages#about_us', as: :about_us

  resources :projects do
  	resources :surveys, except: [ :show, :edit, :destroy, :index]
  end
  resources :surveys, only: [ :show, :destroy, :index] do
    resources :survey_questions, only: [:create, :update]
    resources :question_answers, except: [:edit, :update, :destroy]
    resources :welcome_messages, only: [:new, :create]
    resources :thankyou_screens, only: [:create]
  end

  resources :survey_questions, except: [ :update, :create]

  resources :participants, except: [:edit, :update, :destroy]

  resources :users, path: '', only: [:show]



  post 'surveys/feature', to: 'surveys#feature', as: :feature_survey


end
