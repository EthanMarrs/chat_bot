class Mutations::SendMessage < Mutations::BaseMutation
  null true
  argument :conversation_id, ID, loads: Types::ConversationType
  argument :text, String

  field :conversation, Types::ConversationType
  field :errors, [String], null: false

  def resolve(args)
    SendMessageService.call(conversation: args[:conversation], message: args[:text])

    {
      conversation: args[:conversation],
      errors: []
    }
  rescue ActiveRecord::RecordInvalid
    {
      conversation: nil,
      errors: message.errors.full_messages
    }
  end
end
