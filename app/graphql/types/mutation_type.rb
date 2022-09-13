module Types
  class MutationType < Types::BaseObject
    field :create_conversation, mutation: Mutations::CreateConversation
    field :send_message, mutation: Mutations::SendMessage
  end
end
