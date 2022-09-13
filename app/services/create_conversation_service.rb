class CreateConversationService
  def call
    result = Chat::Bot.new_session

    conversation = Conversation.create!(session_id: result.session_id)
    conversation.messages.create!(text: result.fulfillment_text, from: :bot)

    conversation
  end

  def self.call
    new.call
  end
end
