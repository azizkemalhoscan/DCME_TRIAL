class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
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
    @token = ENV["TYPEFORM_API_TOKEN"]
    @project = Project.new(project_params)
    @project.user_id = current_user.id

     if @project.save
      begin
        response =
          RestClient.post(
            "https://api.typeform.com/themes", {
              "background": {
              "href": "https://images.typeform.com/images/VB37Vp7QpDiQ",
                "layout": "fullscreen"
              },
              "colors": {
                "answer": "#FCCD08",
                "background": "#F8F8F8",
                "button": "#413D56",
                "question": "#413D56"
              },
              "font": "Karla",
              "has_transparent_button": false,
              "name": "dcme.today",
              "visibility": "private"
            }.to_json, Authorization: "bearer #{@token}")

      rescue Exception =>
        raise
      end
      @response = JSON.parse(response)
      @project.theme = @response["id"]
      @project.save

      redirect_to projects_path
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
