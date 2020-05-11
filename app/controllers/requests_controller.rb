class RequestsController < ApplicationController

	def create
		user = User.find_by(id: params[:user])
		project = Project.find_by(id: params[:project])
		rank = params[:rank]
		request = Request.new(user: user,project: project,rank: rank)

		if request.save 
			respond_to do |format|
				flash.now[:notice] = "Request sent to the project manager"
				format.js {render partial: 'requests/result'}
			end
		end
	end

	def destroy

	end

	def index 
		project = Project.find_by(id: params[:project])
		@requests = Request.where(" project_id = ? AND accepted = ? AND rejected = ?", project.id,false, false).all
	end

	def accept
		request_id = params[:id]
		request = Request.find_by(id: request_id)
		project = Project.find_by(id: params[:project])
		user = User.find_by(id: params[:user])

		if request 
			request.accepted = true
			request.save
			Membership.create(project: project, user: user,rank: params[:rank] )
			
		end
		flash[:notice] = "You accepted the request"
		redirect_to requests_path(project: project)
	end

	def decline
		request_id = params[:id]
		request = Request.find_by(id: request_id)
		project = Project.find_by(id: params[:project])

		if request 
			request.rejected = true
			request.save

		end
		flash[:notice] = "You rejected the request"
		redirect_to requests_path(project: project)
	end
end
