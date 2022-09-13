class SendMessageService
  def initialize(conversation:, message:)
    @conversation = conversation
    @message = message
  end

  def call
    conversation.messages.create!(text: message, from: :user)

    result = Chat::Bot.detect_intent(message: message, session_id: conversation.session_id)

    conversation.messages.create!(
      text: result.fulfillment_text,
      from: :bot
    )
  end

  def self.call(conversation:, message:)
    new(conversation: conversation, message: message).call
  end

  private

  attr_accessor :conversation, :message
end
