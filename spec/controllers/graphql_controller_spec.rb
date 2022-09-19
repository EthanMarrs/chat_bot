RSpec.describe GraphqlController do
  describe "POST execute" do
    let(:conversation) { create(:conversation) }
    let(:conversation_id) { ChatBotSchema.id_from_object(conversation) }
    let(:chat_result) { double("Chat::Result", fulfillment_text: "Testing", session_id: "123") }
    let(:variables) { GraphqlHelpers.to_camel_case({send_message_input: {conversation_id: conversation_id, text: "test"}}) }
    let(:query_string) do
      <<-GRAPHQL
        mutation sendMessage($sendMessageInput: SendMessageInput!) {
          sendMessage(input: $sendMessageInput) {
              conversation {
                messages {
                  text
                }
              }
          }
        }
      GRAPHQL
    end

    before do
      allow(Chat::Bot).to receive(:detect_intent).and_return(chat_result)
    end

    it "executes the query" do
      expect(ChatBotSchema).to receive(:execute).with(
        query_string, variables: variables, context: {}, operation_name: nil
      ).and_call_original

      post :execute, params: {query: query_string, variables: variables}
    end

    it "renders JSON data" do
      post :execute, params: {query: query_string, variables: variables}

      data = JSON.parse(response.body)
      expect(data.dig("data", "sendMessage", "conversation", "messages", 0, "text")).to eq("test")
    end

    it "returns a 200 response" do
      post :execute, params: {query: query_string, variables: variables}

      expect(response).to have_http_status(:success)
    end
  end
end
