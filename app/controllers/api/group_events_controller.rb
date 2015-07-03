class API::GroupEventsController < ApplicationController
  before_action :set_group_event, only: [:show, :destroy]

  respond_to :json

  def index
    @group_events = GroupEvent.all

    render json: @group_events
  end

  def show
    render json: @group_event
  end

  def create
    @group_event = GroupEvent.create(group_event_params)
  end

  def destroy
    @group_event.delete!
  end


  private

  def group_event_params
    params.require(:group_event).permit(
      :name,
      :description,
      :location,
      :aasm_state,
      :duration,
      :starts_at,
      :ends_at,
    ).merge(description: markdown(params[:group_event][:description]))

    starts_at = params[:group_event][:starts_at]

    ends_at = params[:group_event][:ends_at].presence || starts_at + params[:group_event][:duration].days
    params[:group_event][:ends_at] = ends_at

    duration = params[:group_event][:duration].presence || (ends_at - starts_at).to_i
    params[:group_event][:duration] = duration
  end

  def set_group_event
    @group_event = GroupEvent.find(params[:id])
  end
  
end
