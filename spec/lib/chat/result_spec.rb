RSpec.describe Chat::Result do
  describe "#new" do
    it "sets instance variables" do
      instance = described_class.new(session_id: "123", initial_message: "Hi!", fulfillment_text: "OK")

      expect(instance.session_id).to eq("123")
      expect(instance.initial_message).to eq("Hi!")
      expect(instance.fulfillment_text).to eq("OK")
    end
  end
end
