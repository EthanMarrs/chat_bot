# Borrowed from GitLab's GraphQL implementation.
# See: https://gitlab.com/gitlab-org/gitlab/-/blob/master/spec/support/matchers/graphql_matchers.rb

RSpec::Matchers.define :have_graphql_fields do |*expected|
  def expected_field_names
    Array.wrap(expected).map { |name| GraphqlHelpers.fieldnamerize(name) }
  end

  @allow_extra = false

  chain :only do
    @allow_extra = false
  end

  chain :at_least do
    @allow_extra = true
  end

  match do |kls|
    keys = kls.fields.keys.to_set
    fields = expected_field_names.to_set

    next true if fields == keys
    next true if @allow_extra && fields.proper_subset?(keys)

    false
  end

  failure_message do |kls|
    missing = expected_field_names - kls.fields.keys
    extra = kls.fields.keys - expected_field_names

    message = []

    message << "is missing fields: <#{missing.inspect}>" if missing.any?
    message << "contained unexpected fields: <#{extra.inspect}>" if extra.any? && !@allow_extra

    message.join("\n")
  end
end

RSpec::Matchers.define :include_graphql_fields do |*expected|
  expected_field_names = expected.map { |name| GraphqlHelpers.fieldnamerize(name) }

  match do |kls|
    expect(kls.fields.keys).to include(*expected_field_names)
  end

  failure_message do |kls|
    missing = expected_field_names - kls.fields.keys
    "is missing fields: <#{missing.inspect}>" if missing.any?
  end
end

RSpec::Matchers.define :have_graphql_field do |field_name, args = {}|
  match do |kls|
    field = kls.fields[GraphqlHelpers.fieldnamerize(field_name)]

    expect(field).to be_present

    args.each do |argument, value|
      expect(field.send(argument)).to eq(value)
    end
  end
end

RSpec::Matchers.define :have_graphql_mutation do |mutation_class|
  match do |mutation_type|
    field = mutation_type.fields[GraphqlHelpers.fieldnamerize(mutation_class.graphql_name)]

    expect(field).to be_present
    expect(field.resolver).to eq(mutation_class)
  end
end

RSpec::Matchers.define :have_graphql_arguments do |*expected|
  include GraphqlHelpers

  def expected_names(field)
    @names ||= Array.wrap(expected).map { |name| GraphqlHelpers.fieldnamerize(name) }

    if field.type.try(:ancestors)&.include?(GraphQL::Types::Relay::BaseConnection)
      @names | %w[after before first last]
    else
      @names
    end
  end

  match do |field|
    names = expected_names(field)

    expect(field.arguments.keys).to contain_exactly(*names)
  end

  failure_message do |field|
    names = expected_names(field).inspect
    args = field.arguments.keys.inspect

    "expected #{field.name} to have the following arguments: #{names}, but it has #{args}."
  end
end
