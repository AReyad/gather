# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :event_view_authorized?, :event_host?
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protected

    def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    end

    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to signin_path
      end
    end

  def check_event_date
    redirect_to root_path and return if @event.past?
  end

  def event_host?(current_event = @event)
    current_user && current_user.id == current_event.host_id
  end

  def authorize_private_event_view
    redirect_to root_path and return unless event_view_authorized?
  end

  def event_view_authorized?(current_event = @event)
    return true if current_event.public_event?

    event_host?(current_event) || (current_event.private_event? && current_event.attendees.include?(current_user))
  end
end
