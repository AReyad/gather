class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: [ :show ]
  def index
    @events = Event.includes(:host).all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      @event.attendees << current_user
      redirect_to user_event_path(current_user.username, @event.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.expect(event: [ :title, :description, :date, :time ])
  end

  def set_event
    @event = Event.includes(:attendees).find(params[:id])
  end
end
