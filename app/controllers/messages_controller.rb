class MessagesController < ApplicationController
  def new
    @session_id = message_params[:session_id]
  end

  def show
  end

  def create
    result = IntentDetectionService.call(
      session_id: message_params[:session_id],
      message: message_params[:message]
    )
    
    @text = result.response

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to :show }
    end
  end

  private

  def message_params
    params.permit(:session_id, :message)
  end
end
