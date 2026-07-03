class EventsController < ApplicationController
  def index
    @events = Event.all.includes(:host)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.expect(event: [ :title, :description, :date, :time ])
  end
end
