class ProjectsController < ApplicationController


    def create
      name = params[:name]
      description = params[:description]
      start_date = params[:start_date]
      dead_line = params[:dead_line]
      image = params[:image]

      @project = Project.new(name: name, description: description, start_date: start_date, dead_line: dead_line, user: current_user)
      @membership = Membership.new(user: current_user, project: @project, rank: "Project Manager")

      @project.save 
      @membership.save


      if @project.save && @membership.save
        
        flash[:notice] = "The Project was successfully created"
        redirect_to projects_path


      else
        flash[:alert] = "You cannot leave the fields blank"
        redirect_to projects_path

      end
  end

  def show
      @project = Project.find_by(id: params[:id])
      # @admin = current_user.rank
      
    if @project.users.include? current_user
      @user_rank = Membership.where(user: current_user,project: @project).first.rank
    else
      @admin = current_user.rank
    end
    @request = @project.requests.where(accepted: false, rejected: false).count
    # puts params[:id]
  end


  def index
    @user = User.where(rank: "Admin",id: current_user.id)
    @projects = current_user.projects.order! 'dead_line ASC'
    # @projects = Project.where(user: current_user).order! 'dead_line ASC'

  end


  def destroy
    @project = Project.find_by(id: params[:id])
    @project.destroy
    flash[:notice] = "#{@project.name} deleted successfully"
    redirect_to projects_path
  end

  def request_projects
      @projects = Project.all
     
  end
  # To search members

  def search_members
    @member = User.where(email: params[:member], company_name: current_user.company_name).first

    @project = Project.find_by(id: params[:project])
    @rank = params[:rank]

    if @member
      respond_to do |format|
        format.js {render partial: "projects/result"}
      end
    else
      respond_to do |format|
        flash.now[:notice] = "This user is not registered"
        format.js {render partial: "projects/result"}
      end
    end
  end

 
end
