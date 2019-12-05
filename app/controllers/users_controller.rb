class UsersController < ApplicationController

  def show
    @all_surveys = []
    @projects = Project.where(user: current_user)
    @projects.each do |project|
      project.surveys.each do |survey|
        if survey.completed
          @all_surveys << survey
        end
      end
    end
  end
end
