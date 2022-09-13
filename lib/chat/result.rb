module Chat
  class Result
    attr_accessor :session_id, :initial_message, :fulfillment_text

    def initialize(**args)
      @session_id = args[:session_id]
      @initial_message = args[:initial_message]
      @fulfillment_text = args[:fulfillment_text]
    end
  end
end
