class IntentDetectionService
  def initialize(message: "hello", session_id: nil)
    @message = message
    @session_id = session_id || generate_session_id
  end

  def call
    response = client.detect_intent(request)

    OpenStruct.new(
      session_id: session_id,
      response: response.query_result.fulfillment_text
    )
  end

  def self.call(message: "hello", session_id: nil)
    new(message: message, session_id: session_id).call
  end

  private

  attr_accessor :message, :session_id

  def client 
    Google::Cloud::Dialogflow.sessions
  end

  def generate_session_id
    random_id = SecureRandom.uuid
    project_id = Rails.application.credentials.google.project_id

    "projects/#{project_id}/agent/sessions/#{random_id}"
  end

  def query_input
    {
      text: {
        text: message,
        language_code: "EN"
      } 
    }
  end

  def request
    Google::Cloud::Dialogflow::V2::DetectIntentRequest.new(
      session: session_id,
      query_input: query_input
    )
  end
end
