require "google/cloud/dialogflow"
require "google/cloud/dialogflow/v2/sessions"

Google::Cloud::Dialogflow.configure do |config|
  config.credentials = Rails.application.credentials.google
end
