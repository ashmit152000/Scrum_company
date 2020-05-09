class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company_name,:first_name,:last_name,:rank])
  end

  def after_sign_in_path_for(resource)
    add_projects_path
end



end
