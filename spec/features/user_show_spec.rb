require 'rails_helper'

describe 'profile page without posts' do
  let(:user) { User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }

  before { visit user_path(user) }

  context 'with no posts' do
    it 'shows the profile details' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Number of posts: 0')
      expect(page).to have_css('img[src="url"]')
    end

    it 'shows no posts for a user with no posts' do
      expect(page).to have_content('No posts')
    end

    it 'shows a button to create a post' do
      expect(page).to have_content('Create New Post')
    end
  end

  context 'adds a new post' do
    before do
      click_link 'Create New Post'
      fill_in 'post_title', with: 'This is a title'
      fill_in 'post_text', with: 'This is a post'
      click_button 'Create Post'
    end

    it 'shows the new post details' do
      expect(page).to have_content('This is a title')
      expect(page).to have_content('This is a post')
      expect(page).to have_content('Comments: 0')
      expect(page).to have_content('Likes: 0')
      expect(page).to have_button('Add Comment')
      expect(page).to have_button('Like Post')
    end

    it 'allows liking the post' do
      click_button 'Like Post'
      expect(page).to have_content('Likes: 1')
    end

    it 'allows adding comments' do
      click_button 'Add Comment'
      fill_in 'comment_comment', with: 'This is a comment'
      click_button 'Add Comment'
      expect(page).to have_content('This is a comment')
      expect(page).to have_content('Comments: 1')
    end
  end
end

describe 'profile page with posts' do
  let(:user) { User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }
  let!(:posts) do
    Post.create([
                  { author: user, title: 'First post', text: 'This is my first post' },
                  { author: user, title: 'Second post', text: 'This is my second post' },
                  { author: user, title: 'Third post', text: 'This is my third post' },
                  { author: user, title: 'Fourth post', text: 'This is my fourth post' }
                ])
  end

  before { visit user_path(user) }

  context 'shows' do
    it 'a summary of posts' do
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_content('This is my second post')
      expect(page).to have_content('This is my third post')
      expect(page).to have_content('This is my fourth post')
    end

    it 'only the last three posts' do
      expect(page).to_not have_content('This is my first post')
    end
  end
end
