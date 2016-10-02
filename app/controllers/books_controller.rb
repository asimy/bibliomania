class BooksController < ApplicationController
  def search
    @search_page = Book.search(book_params[:search_term])

    @favorited_collection = favorited

    render :index
  end

  def create
  end

  def show
  end

  def index
  end

  def update
    book = Book.find_or_create_by(book_params)
    book.add_favorite
    book.save!

    @favorited_collection = favorited
  end

  private
  def book_params
    params.require(:book).permit(:search_term, :google_book_id, :thumbnail_link, :title, :authors)
  end

  def favorited
    Book.all.order('favorited_count desc')
  end
end
