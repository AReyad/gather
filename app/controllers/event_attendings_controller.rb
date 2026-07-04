class EventAttendingsController < ApplicationController
  before_action :set_event, only: [ :create ]
  before_action :authenticate_user!

  def create
    EventAttending.create(attending_event_params)
    redirect_to user_event_path(params[:username], params[:id])
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def attending_event_params
    { event_attendee_id: current_user.id, attended_event_id: params[:id] }
  end
end
