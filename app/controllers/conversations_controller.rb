class ConversationsController < ApplicationController
  def index
    result = SessionCreator.call
    
    @session_id = result.session_id
    @initial_message = result.response
  end
end
