class DiscussionMessageCreatedJob < ApplicationJob
  include SuckerPunch::Job

  def perform(message)
    response = client.generate_response(message)

    Turbo::StreamsChannel.broadcast_append_to(
      "discussion_messages",
      target: "discussion_messages",
      partial: "messages/message", locals: { message_content: response, response: true }
    )
  end

  private

  def client
    api_key = Rails.env.test? ? "test_api_key" : ENV['OPENAI_API_KEY']
    OpenAiClient.new(api_key)
  end
end
