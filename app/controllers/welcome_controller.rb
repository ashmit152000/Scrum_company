class WelcomeController < ApplicationController
  def index
  end

  def projects
    @project = Project.new
  end
end
