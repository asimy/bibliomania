class BooksController < ApplicationController
  def search
    start_index = params[:start_index] || Book::BOOK_SEARCH_DEFAULT_START_INDEX
    max_results = params[:max_results] || Book::BOOK_SEARCH_DEFAULT_MAX_RESULTS
    @search_page = Book.search(book_params[:search_term], start_index, max_results)
    # Not strictly necessary to use find_or_create_by, but it's a quick way of
    # avoiding duplicating saved searches
    SavedSearch.find_or_create_by(search_string: book_params[:search_term])

    @favorited_collection = favorited(params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js   { render :index }
    end

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
