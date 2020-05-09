class MembershipsController < ApplicationController

  def create

    @member = User.find_by(id: params[:user])
    @project = Project.find_by(id: params[:project])
    @rank = params[:rank]
    @memberships = Membership.create(user: @member, project: @project, rank: @rank)
    if @memberships
      respond_to do |format|
        flash[:notice] = "User added as member"
        format.html {redirect_to  project_path(@project)}
      end

    end

  end

end
