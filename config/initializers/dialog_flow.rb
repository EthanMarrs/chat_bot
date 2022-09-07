require "google/cloud/dialogflow"

Google::Cloud::Dialogflow.configure do |config|
  config.credentials = Rails.application.credentials.google
end
