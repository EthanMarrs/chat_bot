class Mutations::CreateConversation < Mutations::BaseMutation
  null true

  field :conversation, Types::ConversationType
  field :errors, [String], null: false

  def resolve
    conversation = CreateConversationService.call

    {
      conversation: conversation,
      errors: []
    }
  rescue ActiveRecord::RecordInvalid
    {
      conversation: nil,
      errors: conversation.errors.full_messages
    }
  end
end
