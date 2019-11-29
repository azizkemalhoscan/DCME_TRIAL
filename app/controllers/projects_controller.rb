class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  def index
    # @projects = policy_scope(Project)
    # authorize @projects
    @projects = Project.all.reverse
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    

     if @project.save
      respond_to do |format|
            format.html { redirect_to project_path(@project) }
            format.js
          end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project.update(params[project_params])
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
    # authorize @project # For Pundit, CHECK necessity!
  end

  def project_params
    params.require(:project).permit(:name) # CHANGE HERE!
  end
end
