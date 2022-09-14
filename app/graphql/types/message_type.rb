module Types
  class MessageType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :text, String, null: true
    field :from, Types::MessageFromEnum, null: true
  end
end
