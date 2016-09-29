class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string  'title'
      t.string  'author_first_name'
      t.string  'author_last_name'
      t.text    'description'
      t.integer 'favorited_count', default: 0
      t.timestamps null: false
    end
  end
end
