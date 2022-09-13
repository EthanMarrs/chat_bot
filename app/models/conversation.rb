class Conversation < ApplicationRecord
  has_many :messages, inverse_of: :conversation
end
