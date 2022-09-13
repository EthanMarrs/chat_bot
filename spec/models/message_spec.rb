RSpec.describe Message, type: :model do
  it { should belong_to(:conversation) }
  it { should validate_presence_of(:conversation) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:text) }
end
