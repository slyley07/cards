class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  def after_sign_in_path_for(resource)
  	project_path(resource.projects.last)
  end
end