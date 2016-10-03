class BooksController < ApplicationController
  def search
    @search_page = Book.search(book_params[:search_term])

    @favorited_collection = favorited(params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js   { render :index }
    end

  end

  def create
  end

  def show
  end

  def index
    @favorited_collection = favorited(params[:page])
  end

  def update
    book = Book.find_or_create_by(book_params)
    book.add_favorite
    book.save!

    @favorited_collection = favorited(params[:page] || 1)
  end

  private
  def book_params
    params.require(:book).permit(:search_term, :google_book_id, :thumbnail_link, :title, :authors)
  end

  def favorited(page = 1)
    Book.paginate(page: page).order('favorited_count desc')
  end
end
