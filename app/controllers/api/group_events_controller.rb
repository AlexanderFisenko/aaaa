class API::GroupEventsController < ApplicationController

  respond_to :json

  def index
    respond_with GroupEvent.all
  end

  def show
    respond_with GroupEvent.find(params[:id])
  end

  def create
    respond_with GroupEvent.create(group_event_params)
  end

  def update
    respond_with GroupEvent.update(params[:id], group_event_params)
  end

  def destroy
    respond_with GroupEvent.delete!(params[:id])
  end


  private

  def group_event_params
    params.require(:group_event).permit(
      :name,
      :original_description,
      :location,
      :aasm_state,
      :duration,
      :starts_at,
      :ends_at,
    ).merge(formatted_description: markdown(params[:group_event][:original_description]))

    starts_at = params[:group_event][:starts_at]

    ends_at = params[:group_event][:ends_at].presence || starts_at + params[:group_event][:duration].days
    params[:group_event][:ends_at] = ends_at

    duration = params[:group_event][:duration].presence || (ends_at - starts_at).to_i
    params[:group_event][:duration] = duration
  end

end
