class Mutations::SendMessage < Mutations::BaseMutation
  null true
  argument :conversation_id, ID, loads: Types::ConversationType
  argument :text, String

  field :message, Types::MessageType
  field :errors, [String], null: false

  def resolve(args)
    message = SendMessageService.call(conversation: args[:conversation], message: args[:text])

    {
      message: message,
      errors: []
    }
  rescue ActiveRecord::RecordInvalid
    {
      message: nil,
      errors: message.errors.full_messages
    }
  end
end
