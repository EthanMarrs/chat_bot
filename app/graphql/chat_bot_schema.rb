class ChatBotSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    # if err.is_a?(GraphQL::InvalidNullError)
    #   # report to your bug tracker here
    #   return nil
    # end
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    case obj
    when Conversation
      Types::ConversationType
    when MessageType
      Types::MyInterface
    else
      raise("Unexpected object: #{obj}")
    end
  end

  # Stop validating when it encounters this many errors:
  validate_max_errors(100)

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition = nil, query_ctx = nil)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    object.to_sgid_param(expires_in: 1.day, for: "chat_bot")
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, query_ctx = nil)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    GlobalID::Locator.locate_signed(global_id, for: "chat_bot")
  end
end
