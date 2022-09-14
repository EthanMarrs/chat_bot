RSpec.describe "Conversation query" do
  let(:conversation) { create(:conversation) }
  let!(:message) { create(:message, conversation: conversation) }
  let(:conversation_id) { ChatBotSchema.id_from_object(conversation) }
  let(:query_string) do
    <<-GRAPHQL
        query conversation($id: ID!) {
          conversation(id: $id) {
            id
            sessionId
            createdAt
            updatedAt
            messages {
              id
              text
              from
              createdAt
              updatedAt
            }
          }
        }
    GRAPHQL
  end

  it "returns the data" do
    result = ChatBotSchema.execute(query_string, variables: {id: conversation_id})
    data = GraphqlHelpers.to_snake_case(result["data"])

    expected_result = {
      conversation: {
        id: ChatBotSchema.id_from_object(conversation),
        session_id: conversation.session_id,
        created_at: anything,
        updated_at: anything,
        messages: [
          {
            id: ChatBotSchema.id_from_object(message),
            text: message.text,
            from: "BOT",
            created_at: anything,
            updated_at: anything
          }
        ]
      }
    }

    expect(data).to match(expected_result)
  end
end
