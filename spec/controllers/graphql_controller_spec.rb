RSpec.describe GraphqlController do
  describe "POST execute" do
    let(:conversation) { create(:conversation) }
    let(:conversation_id) { ChatBotSchema.id_from_object(conversation) }
    let(:query_string) do
      <<-GRAPHQL
        query conversation($id: ID!) {
          conversation(id: $id) {
            sessionId
          }
        }
      GRAPHQL
    end

    it "executes the query" do
      expect(ChatBotSchema).to receive(:execute).with(
        query_string, variables: {id: conversation_id}, context: {}, operation_name: nil
      ).and_call_original

      post :execute, params: {query: query_string, variables: {id: conversation_id}}
    end

    it "renders JSON data" do
      post :execute, params: {query: query_string, variables: {id: conversation_id}}

      data = JSON.parse(response.body)
      expect(data.dig("data", "conversation", "sessionId")).to eq(conversation.session_id)
    end

    it "returns a 200 response" do
      post :execute, params: {query: query_string, variables: {id: conversation_id}}

      expect(response).to have_http_status(:success)
    end
  end
end
