require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) {create(:book, favorited_count: 12)}
  let(:other_book) {create(:book, favorited_count: 0)}

  it "increments favorite count by 1 when book is favorited" do
    expect {book.add_favorite}.to change {book.favorited_count}.by 1
  end

  it "decrements favorite count by 1 when book is unfavorited" do
    expect {book.remove_favorite}.to change {book.favorited_count}.by -1
  end

  it "doesn't reduce favorited count below 0" do
    expect {other_book.remove_favorite}.to change {other_book.favorited_count}.by 0
  end
end
