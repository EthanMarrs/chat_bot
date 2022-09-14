module Types
  class MessageFromEnum < Types::BaseEnum
    value "USER", "Message sent by user.", value: :user
    value "BOT", "Message sent by bot.", value: :bot
  end
end
