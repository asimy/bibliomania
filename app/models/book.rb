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
require "uri"

class Book < ActiveRecord::Base

  GOOGLE_BOOKS_SEARCH_API_ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q='

  def self.search(term, start_index = 0)
    return SearchPage.new("Please enter term") if term.blank?

    sanitized_term = URI.escape(term.gsub(/[?& ]/,'+'))
    search_result = RestClient.get "#{GOOGLE_BOOKS_SEARCH_API_ENDPOINT}#{sanitized_term}&startIndex=#{start_index}"

    return SearchPage.new("An error occurred while trying to search Google Books (code: #{search_result.code})") unless search_result.code == 200

    extract_search_page(search_result, start_index)
  end

  def add_favorite
    self.favorite_count += 1
  end

  def remove_favorite
    self.favorite_count = Math.max(0, self.favorite_count - 1)
  end

  private
  def self.extract_search_page(search_result, start_index)
    general_info = JSON.parse(search_result.body)
    sp = SearchPage.new('')
    sp.results = general_info["items"].map {|book_record| {
                                        google_book_id: book_record["id"],
                                        thumbnail_link: book_record["volumeInfo"]["imageLinks"]["thumbnail"],
                                        title: book_record["volumeInfo"]["title"],
                                        subtitle: book_record["volumeInfo"]["subtitle"],
                                        authors: book_record["volumeInfo"]["authors"].join(', '),
                                        description: book_record["volumeInfo"]["description"]
                                      }}
    sp.start_index = start_index
    sp.total_count = general_info["totalItems"]
    sp
  end
end
