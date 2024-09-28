require 'rails_helper'

RSpec.describe DiscussionMessageCreatedJob, type: :job do
  describe "#perform_later" do
    it "sets message to be sent through the OpenAI client" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        DiscussionMessageCreatedJob.perform_later('Hello!')
      }.to have_enqueued_job
    end
  end
end
