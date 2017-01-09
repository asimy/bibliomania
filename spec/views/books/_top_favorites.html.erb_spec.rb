require 'rails_helper'

RSpec.describe "books/_top_favorites", type: :view do
  let(:book) {create(:book, favorited_count: 2)}
  it "displays favorites list" do
    assign(:favorited_collection, create_list(:book, 2 , favorited_count: 12) << book)

    rendered
    expect(rendered).to have_content(book.title)
  end

  it "doesn't freak out if there are no favorites" do
    assign(:favorited_collection, nil)

    rendered
    expect(rendered).to be_empty
  end
end
