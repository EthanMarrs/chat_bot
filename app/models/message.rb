class Message < ApplicationRecord
  belongs_to :conversation
  default_scope { order(created_at: :asc) }

  enum from: [:user, :bot]

  validates :conversation, :from, :text, presence: true
end
