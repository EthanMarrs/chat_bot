require "google/cloud/dialogflow/v2/sessions"

RSpec.describe IntentDetectionService do
  describe ".call" do
    let(:query_result) { double("Google::Cloud::Dialogflow::V2::QueryResult", fulfillment_text: "Success")}
    let(:detect_intent_response) { double("Google::Cloud::Dialogflow::V2::DetectIntentResponse", query_result: query_result ) }
    let(:client) { double("Google::Cloud::Dialogflow::V2::Sessions::Client", detect_intent: detect_intent_response) }

    before do
      expect(Google::Cloud::Dialogflow).to receive(:sessions).and_return(client)
    end

    it "creates a new Google::Cloud::Dialogflow::V2::DetectIntentRequest " do
      expect(Google::Cloud::Dialogflow::V2::DetectIntentRequest).to receive(:new).with(
        session: /projects\/chatbot-test-id\/agent\/sessions\/[a-z|A-Z|0-9|-]{36}/,
        query_input: {
          text: {
            text: "Hello",
            language_code: "EN"
          } 
        }
      )

      described_class.call
    end

    it "formats the response data" do
      expect(SecureRandom).to receive(:uuid).and_return('12345')

      result = described_class.call

      expect(result.session_id).to eq("projects/chatbot-test-id/agent/sessions/12345")
      expect(result.response).to eq("Success")
    end
  end
end
