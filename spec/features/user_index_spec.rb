require 'rails_helper'

describe 'home page' do
  before do
    @user = User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test')
    visit '/'
  end

  it 'I can see the username of all other users.' do
    expect(page).to have_content('John Doe')
  end

  it 'I can see the profile picture for each user.' do
    expect(page).to have_css('img[src="url"]')
  end

  it 'I can see the number of posts each user has written.' do
    expect(page).to have_content('Number of posts: 0')
  end

  context 'when I click on a user' do
    before do
      visit '/users'
      all('a', text: 'John Doe')[1].click
    end
    it 'I am redirected to that user\'s show page.' do
      expect(page).to have_content('John Doe\'s Profile')
      expect(page).to have_content('Create New Post')
      expect(page).to have_content('No posts')
    end
  end
end
