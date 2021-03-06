class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_edition

  def current_edition
    Edition.find_by(name: "second")
  end

  def get_user_home_page
    redirect_to evaluation_panel_path
    #check the current user type to redirect non-organizers to their dashboard
  end

  def require_organiser
    unless current_user && current_user.organizer?
      redirect_to root_path, alert: "Login again as a organiser!"
    end
  end

  def find_week
    if params[:week] == "all"
      nil
    elsif params[:week].present?
      current_edition.weeks.find_by(number: params[:week])
    else
      current_edition.weeks.find_by(start: (Time.zone.now).beginning_of_week)
    end
  end
end
