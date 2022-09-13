RSpec.describe Chat::Bot do
  describe "#new" do
    context "when arguments are provided" do
      it "sets instance variables" do
        instance = described_class.new(message: "My message", session_id: "my_session_id")

        expect(instance.message).to eq("My message")
        expect(instance.session_id).to eq("my_session_id")
      end
    end

    context "when no arguments are provided" do
      it "sets default instance variables" do
        instance = described_class.new

        expect(instance.message).to eq("hello")
        expect(instance.session_id).to match(/projects\/chatbot-test-id\/agent\/sessions\/[a-z|A-Z0-9-]{36}/)
      end
    end
  end

  describe "#detect_intent" do
    let(:query_result) { double("Google::Cloud::Dialogflow::V2::QueryResult", fulfillment_text: "Success") }
    let(:detect_intent_response) { double("Google::Cloud::Dialogflow::V2::DetectIntentResponse", query_result: query_result) }
    let(:client) { double("Google::Cloud::Dialogflow::V2::Sessions::Client", detect_intent: detect_intent_response) }

    before do
      expect(Google::Cloud::Dialogflow).to receive(:sessions).and_return(client)
    end

    it "creates a new Google::Cloud::Dialogflow::V2::DetectIntentRequest " do
      expect(Google::Cloud::Dialogflow::V2::DetectIntentRequest).to receive(:new).with(
        session: /projects\/chatbot-test-id\/agent\/sessions\/[a-z|A-Z0-9-]{36}/,
        query_input: {
          text: {
            text: "hello",
            language_code: "EN"
          }
        }
      )

      described_class.new.detect_intent
    end

    it "formats the response data" do
      expect(SecureRandom).to receive(:uuid).and_return("12345")

      result = described_class.new.detect_intent

      expect(result.session_id).to eq("projects/chatbot-test-id/agent/sessions/12345")
      expect(result.initial_message).to eq("hello")
      expect(result.fulfillment_text).to eq("Success")
    end
  end

  describe ".detect_intent" do
    let(:chat_bot) { double("Chat::Bot", detect_intent: nil) }

    it "creates a new instance of Chat::Bot and calls #detect_intent with the provided arguments" do
      expect(described_class).to receive(:new).with(message: "Hello world", session_id: "321").and_return(chat_bot)

      described_class.detect_intent(message: "Hello world", session_id: "321")
    end
  end

  describe ".new_session" do
    let(:chat_bot) { double("Chat::Bot", detect_intent: nil) }

    it "creates a new instance of Chat::Bot and calls #detect_intent with default arguments" do
      expect(described_class).to receive(:new).with(no_args).and_return(chat_bot)

      described_class.new_session
    end
  end
end
