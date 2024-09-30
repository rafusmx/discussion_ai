class MessagesController < ApplicationController
  def create
    return if message_params[:content].blank?
    render turbo_stream: turbo_stream.append(
      "discussion_messages",
      partial: "messages/message", locals: { message_content: message_params[:content], response: false }
    )
    DiscussionMessageCreatedJob.perform_now(message_params[:content])
    # DiscussionMessageCreatedJob.perform_async(message_params[:content])
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
