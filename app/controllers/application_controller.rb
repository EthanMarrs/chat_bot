class ApplicationController < ActionController::Base
  before_action :restrict_request_origin

  def restrict_request_origin
    return if Rails.env.development? || Rails.env.test?
    return if request.domain == Rails.application.credentials.domain

    render status: :forbidden, json: {error: "You do not have authorization to make this request."}
  end
end
