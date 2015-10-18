require 'rails_helper'

feature 'commenting' do
  before {Post.create caption: 'Just chillin'}

  scenario 'allows users to leave a comment using a form' do
     visit '/posts'
     click_link 'Leave comment'
     fill_in "Thoughts", with: "so so"
     click_button 'Leave Comment'

     expect(current_path).to eq '/posts'
     expect(page).to have_content('so so')
  end

end