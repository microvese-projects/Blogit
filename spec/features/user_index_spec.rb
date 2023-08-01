require 'rails_helper'

describe 'home page' do
  before do
    @user = User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test')
  end

  it 'loads with a list of users' do
    visit '/'
    expect(page).to have_content('John Doe')
    expect(page).to have_content('Number of posts: 0')
    expect(page).to have_css('img[src="url"]')
  end

  context 'on click' do
    before do
      visit '/users'
      all('a', text: 'John Doe')[1].click
    end
    it 'shows the user\'s profile' do
      expect(page).to have_content('John Doe\'s Profile')
      expect(page).to have_content('Create New Post')
      expect(page).to have_content('No posts')
    end
  end
end
