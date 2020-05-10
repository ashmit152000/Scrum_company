class RequestsController < ApplicationController

	def create
		user = User.find_by(id: params[:user])
		project = Project.find_by(id: params[:project])
		request = Request.new(user: user,project: project)

		if request.save 
			respond_to do |format|
				flash[:notice] = "You request has been sent"
				format.html {redirect_to projects_path(project)}
			end
		end
	end

	def destroy

	end

	def index 
		project = Project.find_by(id: params[:project])
		@requests = Request.where(project: project).all
	end

	def accept
		request_id = params[:id]
		request = Request.find_by(id: request_id)
		project = Project.find_by(id: params[:project])

		if request 
			request.accepted = true
			request.save
		end

		redirect_to requests_path(project: project)
	end
end
