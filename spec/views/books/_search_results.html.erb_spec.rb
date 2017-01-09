require 'rails_helper'

RSpec.describe "books/_search_results", type: :view do
  it 'displays search results' do
    Struct.new('SearchPage',:results)
    assign(:search_page, Struct::SearchPage.new([{
                google_book_id: 1234,
                thumbnail_link: nil,
                title: "Fake Book",
                subtitle: "Not real at all",
                authors: "Joseph Josef",
                description: "Described"
              }]))
              byebug
    rendered
    expect(rendered).to have_content "Fake book"
  end
end
