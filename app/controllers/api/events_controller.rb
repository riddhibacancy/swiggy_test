class Api::EventsController < Api::BaseController
  before_action :check_event_type!, only: [:create, :update]

  def index
    @events = params[:repo_id].present? ? Repo.find(params[:repo_id]).events : Event.all
    render json: @events, each_serializer: EventSerializer, status: 200
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, serializer: EventSerializer, status: 201
    else
      render json: { error: 'Invalid Data', status: 400 }, status: 400
    end
  end

  def show
    @event = Event.find(params[:id])
    render json: @event, serializer: EventSerializer, status: 200
  end

  private

  def event_params
    params.permit(:event_type, :public, :repo_id, :actor_id)
  end

  def check_event_type!
    valid_event_types = ['PushEvent', 'ReleaseEvent', 'WatchEvent']
    unless valid_event_types.include? params[:event_type]
      render json: { error: 'No such valid event type', status: 400 }, status: 400
    end
  end
end
