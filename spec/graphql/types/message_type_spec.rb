RSpec.describe Types::MessageType do
  it "has the expected fields" do
    expected_fields = %w[id text from created_at updated_at]

    expect(described_class).to have_graphql_fields(expected_fields)
  end
end
