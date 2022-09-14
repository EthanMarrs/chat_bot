RSpec.describe "Mutations::CreateConversation" do
  let(:query_string) do
    <<-GRAPHQL
      mutation createConverdation {
        createConversation(input: {}) {
          conversation {
            id
            sessionId
            messages {
              text
            }
          }
        }
      }
    GRAPHQL
  end

  it "returns the data" do
    chat_result = double("Chat::Result", fulfillment_text: "Testing", session_id: "123")

    expect(Chat::Bot).to receive(:new_session).and_return(chat_result)

    result = ChatBotSchema.execute(query_string)
    data = GraphqlHelpers.to_snake_case(result["data"])

    expected_result = {
      create_conversation: {
        conversation: {
          id: anything,
          session_id: "123",
          messages: [
            {
              text: "Testing"
            }
          ]
        }
      }
    }

    expect(data).to match(expected_result)
  end
end
