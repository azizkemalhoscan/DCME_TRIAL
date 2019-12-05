class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show

    if user_signed_in?
      @all_surveys = []
      @projects = Project.where(user: current_user)
      @projects.each do |project|
        project.surveys.each do |survey|
          if survey.completed
            @all_surveys << survey
          end
        end
      end

    else

      @user = User.where(username: (params[:id])).first
      @user.projects.each do |project|
        project.surveys.each do |survey|
          if survey.featured
            @user_survey = survey
        end
      end
    end
  end
end
end
