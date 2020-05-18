class AssignmentsController < ApplicationController
  def new
  	@project = Project.find_by(id: params[:project_id])
  	@users = @project.users.where.not(id: current_user.id)
  	@assignment = Assignment.new
  end

  def create
  	@user = User.find_by(id: params[:user])
  	@assignment = Assignment.new(assignment_params)
  	@project = Project.find_by(id: params[:project_id])
  	if @assignment.save 
  		respond_to do |format|
        flash[:notice] = "Assignment sent"
  			format.html {redirect_to new_project_assignment_path(@project)}
  		end
  	end
  	
  end

  def show
  
    @a = Assignment.find_by(id: params[:id])
  end

  def index
    @project = Project.find_by(id: params[:project_id])
    @assignments = Assignment.where(project_id: params[:project_id],user_id: current_user.id).paginate(page: params[:page], per_page: 5).order! 'dead_line ASC'
  end


def add_label
  @project = Project.find_by(id: params[:project])
  @assignment = Assignment.find_by(id: params[:assignment])
  @assignment.label = params[:label]
  # @assignment.save

  if @assignment.save
    redirect_to project_assignments_path(@project.id)
  end
end


def admin
  @project = Project.find_by(id: params[:project_id])
  @user = User.find_by(id: params[:user_id])
  @assignments = Assignment.where(project: @project, user: @user, accepted: false, completed: false).paginate(page: params[:page], per_page: 5).order! 'dead_line ASC'

  @assignment_completed = Assignment.where(project: @project, user: @user, accepted: false, completed: true)

  @assignment_accepted = Assignment.where(project: @project, user: @user, accepted: true, completed: true)

  

end

private 
def assignment_params
	params.require(:assignment).permit(:description,:start_date,:dead_line,:user_id,:rating,:completed,:accepted,:rejected,:project_id,:label)
end
  
end
