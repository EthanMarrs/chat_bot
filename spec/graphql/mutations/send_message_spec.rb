RSpec.describe "Mutations::SendMessage" do
  let(:conversation) { create(:conversation) }
  let(:conversation_id) { ChatBotSchema.id_from_object(conversation) }
  let(:query_string) do
    <<-GRAPHQL
      mutation sendMessage($sendMessageInput: SendMessageInput!) {
        sendMessage(input: $sendMessageInput) {
            message {
              text
            }
        }
      }
    GRAPHQL
  end

  it "returns the data" do
    chat_result = double("Chat::Result", fulfillment_text: "Response!", session_id: "123")

    expect(Chat::Bot).to receive(:detect_intent).and_return(chat_result)

    variables = GraphqlHelpers.to_camel_case({send_message_input: {conversation_id: conversation_id, text: "I have a question"}})
    result = ChatBotSchema.execute(query_string, variables: variables)
    data = GraphqlHelpers.to_snake_case(result["data"])

    expected_result = {
      send_message: {
        message: {
          text: "Response!"
        }
      }
    }

    expect(data).to match(expected_result)
  end
end
