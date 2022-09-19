module Types
  class ConversationType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :messages, [Types::MessageType], null: true
  end
end
