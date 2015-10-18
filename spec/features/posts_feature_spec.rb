require 'rails_helper'

feature 'posts' do
	context 'no posts have been added' do
		scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add a post'
    end
	end

	context 'posts have been added' do
		before do
			Post.create(caption: 'Just chillin')
		end

		scenario 'display posts' do
			visit '/posts'
			expect(page).to have_content('Just chillin')
			expect(page).not_to have_content('No posts yet')
		end
	end

	context 'creating posts' do
		scenario 'prompt users to create a post, then displays the post' do
			visit '/posts'
			click_link 'Add a post'
			fill_in 'Caption', with: 'Just chillin'
			click_button 'Create Post'
			expect(page).to have_content 'Just chillin'
			expect(current_path).to eq '/posts'
		end
	end

	context 'editing posts' do

		before {Post.create caption: 'Just chillin'}
			
		scenario 'let a user edit a post' do
			visit '/posts'
			click_link 'Edit post'
			fill_in 'Caption', with: 'Just chillAXIN'
			click_button 'Update Post'
			expect(page).to have_content 'Just chillAXIN'
			expect(current_path).to eq '/posts'
		end
	end

	context 'viewing posts' do
	
		let!(:justchillin){Post.create(caption:'Just chillin')}

	  scenario 'lets a user view a post' do
	  	visit '/posts'
	  	click_link 'Just chillin'
	  	expect(page).to have_content 'Just chillin'
	  	expect(current_path).to eq "/posts/#{justchillin.id}"
	  end
	end

	context 'deleting posts' do

		before {Post.create caption: 'Just chillin'}

		scenario 'removes a post when a user clicks the delete link' do
			visit '/posts'
			click_link 'Delete post'
			expect(page).not_to have_content 'Just chillin'
			expect(page).to have_content 'Post deleted successfully'
		end

		scenario 'removes all reviews associated with a post when it is deleted' do
			visit '/posts'
      click_link 'Leave comment'
      fill_in "Thoughts", with: "so so"
      click_button 'Leave Comment'
      click_link 'Delete post'
      expect(page).not_to have_content 'so so'
		end
	end
end