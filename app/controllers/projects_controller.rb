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

    @assignment_new = Assignment.where(user: current_user, project: @project,created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count

    @assignments_total = Assignment.where(user_id: current_user.id,project: @project.id, accepted: false).count
    
    # puts params[:id]
  end


  def index
    @user = User.where(rank: "Admin",id: current_user.id)
    @projects = current_user.projects.paginate(page: params[:page], per_page: 4).order! 'dead_line ASC'
    @rank = current_user.rank
    
    # @projects = Project.where(user: current_user).order! 'dead_line ASC'

  end


  def edit
    @project = Project.find_by(id: params[:id])
  end


  def update
    @project = Project.find_by(id: params[:id])

   
    if @project.update(name: params[:project][:name],description: params[:project][:description],start_date: params[:project][:start_date],dead_line: params[:project][:dead_line],user_id: params[:project][:user_id])
        respond_to do |format|
          flash[:notice] = "Project edited successfully"
          format.html {redirect_to project_path(@project.id)}
        end
      
    end
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

  def user_show
    @user = User.find_by(id: params[:id])
  end

  def search_members
    @member = User.where(email: params[:member], company_name: current_user.company_name).first

    @project = Project.find_by(id: params[:project])
    @rank = params[:rank]
    @membership = Membership.where(user: @member, project: @project).first
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
