require 'rails_helper'

RSpec.describe "Discussions", type: :system do
  let(:user_query) { "Hello, can you write a haiku that explains the concept of recursion?" }

  before do
    driven_by(:firefox)
    visit root_path
  end

  it "renders the title and welcome text" do
    expect(page).to have_text("DiscussionAI")
    expect(page).to have_text("Hello nice handsome human person.")
  end

  it "renders the message form" do
    expect(page).to have_css(".message-form")
    expect(page).to have_css(".message-input")
    expect(page).to have_css(".message-submit")
  end

  it "renders the user query after submit" do
    message_field = page.find(".message-input")

    message_field.fill_in with: user_query
    click_button "Send"

    expect(page).to have_text("Hello nice handsome human person")
    expect(page).to have_text("> #{user_query}")
  end
end
