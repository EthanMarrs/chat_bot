module Chat
  class Bot
    def initialize(message: "hello", session_id: nil)
      @message = message
      @session_id = session_id || generate_session_id
    end

    def detect_intent
      response = client.detect_intent(request)

      Result.new(
        session_id: session_id,
        initial_message: message,
        fulfillment_text: response.query_result.fulfillment_text
      )
    end

    def self.detect_intent(message:, session_id:)
      new(message: message, session_id: session_id).detect_intent
    end

    def self.new_session
      new.detect_intent
    end

    attr_accessor :message, :session_id

    private

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
end
