RSpec.describe CreateConversationService do
  describe ".call" do
    let(:chat_result) { double("Chat::Result", fulfillment_text: "Testing", session_id: "123") }

    before do
      expect(Chat::Bot).to receive(:new_session).and_return(chat_result)
    end

    it "starts a new chat session" do
      described_class.call
    end

    it "creates a new conversation" do
      conversation = described_class.call

      expect(conversation).to be_present
      expect(conversation).to be_instance_of(Conversation)
    end

    it "creates the initial message" do
      conversation = described_class.call

      expect(conversation.messages.first.text).to eq("Testing")
    end
  end
end
