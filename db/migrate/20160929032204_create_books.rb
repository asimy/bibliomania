class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string  'google_book_id'
      t.string  'thumbnail_link'
      t.string  'title'
      t.string  'subtitle'
      t.string  'authors'
      t.text    'description'
      t.integer 'favorited_count', default: 0
      t.timestamps null: false
    end
  end
end
