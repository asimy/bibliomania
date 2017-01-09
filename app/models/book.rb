# == Schema Information
#
# Table name: books
#
#  id              :integer          not null, primary key
#  google_book_id  :string
#  thumbnail_link  :string
#  title           :string
#  subtitle        :string
#  authors         :string
#  description     :text
#  favorited_count :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rest-client'
require 'uri'
require 'ruby_dig'

class Book < ActiveRecord::Base

  GOOGLE_BOOKS_SEARCH_API_ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q='
  BOOK_SEARCH_DEFAULT_MAX_RESULTS = 5
  BOOK_SEARCH_DEFAULT_START_INDEX = 0

  self.per_page = 5

  def self.search(term, start_index = BOOK_SEARCH_DEFAULT_START_INDEX, max_results = BOOK_SEARCH_DEFAULT_MAX_RESULTS)
    return SearchPage.new("Please enter term") if term.blank?

    sanitized_term = URI.escape(term.gsub(/[?& ]/,'+'))
    search_result = RestClient.get "#{GOOGLE_BOOKS_SEARCH_API_ENDPOINT}#{sanitized_term}&startIndex=#{start_index}&maxResults=#{max_results}"

    return SearchPage.new("An error occurred while trying to search Google Books (code: #{search_result.code})") unless search_result.code == 200

    extract_search_page(search_result, start_index)
  end

  def add_favorite
    self.favorited_count += 1
  end

  def remove_favorite
    self.favorited_count = [0, self.favorited_count - 1].max
  end

  private
  def self.extract_search_page(search_result, start_index)
    general_info = JSON.parse(search_result.body)
    sp = SearchPage.new('')
    sp.results = general_info["items"].map {|book_record| {
                                        google_book_id: book_record["id"],
                                        thumbnail_link: thumbnail(book_record),
                                        title: book_record.dig("volumeInfo","title"),
                                        subtitle: book_record.dig("volumeInfo","subtitle").to_s,
                                        authors: Array(book_record.dig("volumeInfo","authors")).to_sentence,
                                        description: book_record.dig("volumeInfo","description").to_s
                                      }}
    sp.start_index = start_index
    sp.total_count = general_info["totalItems"]
    sp
  end

  def self.thumbnail(book_record)
    book_record.dig("volumeInfo", "imageLinks", "thumbnail") ||
    book_record.dig("volumeInfo", "imageLinks", "smallThumbnail") ||
    '/assets/book_placeholder.png'
  end

end
