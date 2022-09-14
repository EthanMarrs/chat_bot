# Borrowed from GitLab's GraphQL implementation.
# See: https://gitlab.com/gitlab-org/gitlab/-/blob/master/spec/support/helpers/graphql_helpers.rb

module GraphqlHelpers
  def self.fieldnamerize(underscored_field_name)
    underscored_field_name.to_s.camelize(:lower)
  end

  def self.to_snake_case(hash)
    hash.deep_transform_keys { |key| key.to_s.underscore.to_sym }
  end
end
