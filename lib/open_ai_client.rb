require "rest-client"

class OpenAiClient
  OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"

  def initialize(api_key)
    @api_key = api_key
  end

  def generate_response(user_input)
    begin
      response = RestClient.post(OPENAI_API_URL, request_body(user_input), request_headers)
      parse_response(response.body)
    rescue RestClient::RequestTimeout
      "Error: Request timed out."
    rescue RestClient::ExceptionWithResponse => e
      handle_error(e)
    rescue StandardError => e
      "Error: Something went wrong - #{e.message}"
    end
  end

  private

  def request_headers
    {
      "Content-Type": "application/json",
      "Authorization": "Bearer #{@api_key}"
    }
  end

  def request_body(user_input)
    {
      # model: "gpt-3.5-turbo",
      model: "gpt-4",
      messages: [{ role: "user", content: user_input }],
      max_tokens: 150
    }.to_json
  end

  def parse_response(response_body)
    parsed_response = JSON.parse(response_body)
    parsed_response["choices"].first["message"]["content"].strip
  end

  def handle_error(exception)
    case exception.http_code
    when 400
      "Error: Bad Request - #{exception.message}"
    when 401
      "Error: Unauthorized - Check your API key."
    when 500
      "Error: Internal Server Error - Please try again later."
    else
      "Error: #{exception.http_code} - #{exception.message}"
    end
  end
end
