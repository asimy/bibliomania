Rails.application.routes.draw do
  get 'books/search'

  put 'books/update'

  root 'books#index'
end
