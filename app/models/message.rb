class Message < ApplicationRecord
  belongs_to :conversation

  enum from: [:user, :bot]

  validates :conversation, :from, :text, presence: true
end
