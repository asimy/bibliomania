class Book < ActiveRecord::Base
  def self.search(term)
  end

  def add_favorite
    self.favorite_count += 1
  end

  def remove_favorite
    self.favorite_count = Math.max(0, self.favorite_count - 1)
  end

end
