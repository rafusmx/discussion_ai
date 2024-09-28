require 'rails_helper'

RSpec.describe "Discussions", type: :request do

  describe "GET root_path" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET discussion_path" do
    it "returns http success" do
      get discussion_path
      expect(response).to have_http_status(:ok)
    end
  end
end
