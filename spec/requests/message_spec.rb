require 'rails_helper'

RSpec.describe "Message", type: :request do
  let(:api_key) { 'test_api_key' }

  before do
    stub_request(:post, "https://api.openai.com/v1/chat/completions").
      with(
        body: "{\"model\":\"gpt-4\",\"messages\":[{\"role\":\"user\",\"content\":\"Hi!\"}],\"max_tokens\":150}",
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>"Bearer #{api_key}",
      'Content-Length'=>'79',
      'Content-Type'=>'application/json',
      'Host'=>'api.openai.com',
      'User-Agent'=>'rest-client/2.1.0 (darwin23 x86_64) ruby/3.3.4p94'
        }).
      to_return(status: 200, body: "", headers: {})
  end

  describe "POST /message" do
    it "returns http success" do
      post message_path(message: { content: "Hi!" })
      expect(response).to have_http_status(:success)
    end
  end
end
