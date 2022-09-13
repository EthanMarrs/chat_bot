module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :conversation, Types::ConversationType, null: true do
      argument :id, ID, required: true
    end

    def conversation(id:)
      ChatBotSchema.object_from_id(id)
    end
  end
end
