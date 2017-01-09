require 'rails_helper'

RSpec.describe "books/_saved_searches", type: :view do
  context 'when there is a saved search' do
    let(:saved_search) {create(:saved_search, search_string: 'waffles')}

    it 'displays the list of searches' do
      expect(saved_search).to be
      render

      expect(rendered).to have_link 'waffles'
      expect(rendered).to have_content 'Saved searches'
    end

    it 'displays nothing when there are no searches' do
      render

      expect(rendered).not_to have_content 'Saved searches'
    end
  end

end
