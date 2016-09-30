class BooksController < ApplicationController
  def search
    @search_page = Book.search(book_params[:search_term])

    render :index
  end

  def create
  end

  def show
  end

  def index
  end

  def update
  end

  private
  def book_params
    params.require(:book).permit(:search_term, :id, :favorite)
  end
end
