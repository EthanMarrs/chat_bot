class ConversationsController < ApplicationController
  def show
    @session_id = generate_session_id
  end

  private 

  def generate_session_id
    random_id = SecureRandom.uuid
    project_id = Rails.application.credentials.google.project_id

    "projects/#{project_id}/agent/sessions/#{random_id}"
  end
end
