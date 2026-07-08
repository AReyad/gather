class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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
    if @event.past?
      redirect_to root_path and return
    end
  end

  def event_host?
    current_user.id == @event.host_id
  end
end
