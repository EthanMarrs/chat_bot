RSpec.describe SendMessageService do
  describe ".call" do
    let(:conversation) { create(:conversation, session_id: "abcdef") }
    let(:chat_result) { double("Chat::Result", fulfillment_text: "Response", session_id: "123") }

    before do
      allow(Chat::Bot).to receive(:detect_intent).and_return(chat_result)
    end

    it "creates the initial message" do
      described_class.call(conversation: conversation, message: "Example")

      expect(conversation.messages.first.text).to eq("Example")
    end

    it "detects the intent" do
      expect(Chat::Bot).to receive(:detect_intent)
        .with(session_id: "abcdef", message: "Example")
        .and_return(chat_result)

      described_class.call(conversation: conversation, message: "Example")
    end

    it "creates the response message" do
      described_class.call(conversation: conversation, message: "Example")

      expect(conversation.messages.last.text).to eq("Response")
    end

    it "returns the message" do
      result = described_class.call(conversation: conversation, message: "Example")

      expect(result).to be_instance_of(Message)
    end
  end
end
