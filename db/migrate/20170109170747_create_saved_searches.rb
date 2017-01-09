class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :search_string

      t.timestamps null: false
    end
  end
end
