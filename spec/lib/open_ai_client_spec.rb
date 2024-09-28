require "open_ai_client"

RSpec.describe OpenAiClient do
  let(:api_url) { "https://api.openai.com/v1/chat/completions" }
  let(:api_key) { "test_api_key" }
  let(:client) { OpenAiClient.new(api_key) }
  let(:user_input) { "Hello, can you write a haiku that explains the concept of recursion?" }
  let(:haiku_answer) { "Endless path unfolds, \nA pattern within itself, \nSelf-seeking whispers." }

  before do
    stub_request(:post, api_url)
      .with(
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{api_key}"
        },
        body: {
          model: "gpt-4",
          messages: [{ role: "user", content: user_input
           }],
          max_tokens: 150
        }.to_json
      )
  end

  describe "#generate_response" do
    context "when the API request is successful" do
      let(:response_body) do
        {
          choices: [
            { message: { content: haiku_answer } }
          ]
        }.to_json
      end

      before do
        stub_request(:post, api_url)
          .to_return(status: 200, body: response_body)
      end

      it "returns the response content" do
        response = client.generate_response(user_input
        )
        expect(response).to eq(haiku_answer)
      end
    end

    context "when the API request returns 400" do
      before do
        stub_request(:post, api_url)
          .to_return(status: 400, body: "Bad Request")
      end

      it "returns an error message for bad request" do
        response = client.generate_response(user_input
        )
        expect(response).to eq("Error: Bad Request - 400 Bad Request")
      end
    end

    context "when the API request returns 401" do
      before do
        stub_request(:post, api_url)
          .to_return(status: 401, body: "Unauthorized")
      end

      it "returns an error message for unauthorized" do
        response = client.generate_response(user_input
        )
        expect(response).to eq("Error: Unauthorized - Check your API key.")
      end
    end

    context "when the API request returns 500" do
      before do
        stub_request(:post, api_url)
          .to_return(status: 500, body: "Internal Server Error")
      end

      it "returns an error message for server error" do
        response = client.generate_response(user_input
        )
        expect(response).to eq("Error: Internal Server Error - Please try again later.")
      end
    end

    context "when there is a timeout" do
      before do
        stub_request(:post, api_url)
          .to_timeout
      end

      it "returns a timeout error message" do
        response = client.generate_response(user_input
        )
        expect(response).to eq("Error: Request timed out.")
      end
    end

    context "when an unexpected error occurs" do
      before do
        allow(RestClient).to receive(:post).and_raise(StandardError.new("Unexpected error"))
      end

      it "returns a generic error message" do
        response = client.generate_response(user_input
        )
        expect(response).to eq("Error: Something went wrong - Unexpected error")
      end
    end
  end
end
