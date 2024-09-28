require 'rails_helper'

RSpec.describe DiscussionHelper, type: :helper do
  describe ".prompt_stamp" do
    let(:stamp_time) { Time.now }

    it "shows the time formated as HH:MM:SS followed by a >" do
      allow(Time).to receive(:now).and_return(stamp_time)

      expect(helper.prompt_stamp).to eq("#{stamp_time.strftime("%H:%M:%S")}>")
    end
  end
end
