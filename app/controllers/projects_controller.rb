class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def new
  	@project = Project.new
  end

  def index
  	@projects = current_user.projects
  end

  def show
  end

  def edit
  end

  def create
  	@project = Project.new
  	if @project.save
			redirect_to @project, notice: "Look at all of these cards!"
		else
			redirect_to @project, alert: "You're dumb, yo!"
		end
  end

	def update
	  @project = Project.find(params[:id])
	  respond_to do |format|
	    if @project.update(params.require(:project).permit(:title))
	      format.html { redirect_to(@project, notice: 'Project was successfully updated.') }
	      format.json { respond_with_bip(@project) }
	    else
	      format.html { render action: "edit" }
	      format.json { respond_with_bip(@project) }
	    end
	  end
	end

	def destroy
	end

  private

  def set_project
  	@project = Project.find(params[:id])
  end
end
