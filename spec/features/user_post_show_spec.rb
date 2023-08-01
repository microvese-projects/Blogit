require 'rails_helper'

describe 'post page' do
  let(:user) { User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }
  let!(:posts) do
    Post.create([
                  { author: user, title: 'First post', text: 'This is my first post' },
                  { author: user, title: 'Second post', text: 'This is my second post' },
                  { author: user, title: 'Third post', text: 'This is my third post' },
                  { author: user, title: 'Fourth post', text: 'This is my fourth post' }
                ])
  end
  let!(:comments) do
    Comment.create([
                     { author: user, post: posts[0], text: 'This is my first comment!' },
                     { author: user, post: posts[0], text: 'This is my second comment!' }
                   ])
  end

  before { visit user_post_path(user, posts[0]) }

  it 'shows the title and author' do
    expect(page).to have_content('First post by John Doe')
  end

  it 'shows the comments and likes count' do
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 0')
  end

  it 'allows adding of likes' do
    click_button 'Like Post'
    expect(page).to have_content('Likes: 1')
  end

  it 'shows the post body' do
    expect(page).to have_content('This is my first post')
  end

  it 'shows the commentor\'s username and their comment' do
    expect(page).to have_content('John Doe: This is my first comment!')
  end
end