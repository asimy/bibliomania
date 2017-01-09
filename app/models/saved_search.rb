# == Schema Information
#
# Table name: saved_searches
#
#  id            :integer          not null, primary key
#  search_string :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SavedSearch < ActiveRecord::Base
end
