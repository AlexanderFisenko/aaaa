class API::GroupEventsController < ApplicationController

  respond_to :json

  def index
    respond_with :api, GroupEvent.all
  end

  def show
    respond_with :api, GroupEvent.find(params[:id])
  end

  def create
    respond_with :api, GroupEvent.create(group_event_params)
  end

  def update
    respond_with :api, GroupEvent.update(params[:id], group_event_params)
  end

  def destroy
    GroupEvent.find(params[:id]).delete!
    render nothing: true, status: 204
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
    )
  end

end
