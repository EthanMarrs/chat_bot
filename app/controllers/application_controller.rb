class ApplicationController < ActionController::Base
  before_action :restrict_request_origin

  def restrict_request_origin
    return if request.domain == Rails.application.credentials.domain

    render status: :forbidden, json: {error: "You do not have authorization to make this request."}
  end
end
