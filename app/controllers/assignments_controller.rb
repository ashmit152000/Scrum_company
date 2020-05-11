class AssignmentsController < ApplicationController
  def new
  	@project = Project.find_by(id: params[:project_id])
  	@assignment = Assignment.new
  end
end
