RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
end
