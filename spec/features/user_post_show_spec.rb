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

  before(:each) do
    visit user_post_path(user, posts[0])
  end

  after(:each) do
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'I can see the post\'s title.' do
    expect(page).to have_content('First post')
  end

  it 'I can see who wrote the post.' do
    expect(page).to have_content('by John Doe')
  end

  it 'I can see how many comments it has.' do
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 0')
  end

  it 'I can see how many likes it has.' do
    expect(page).to have_content('Likes: 0')
  end

  it 'I can see the post body.' do
    expect(page).to have_content('This is my first post')
  end

  it 'allows adding of likes' do
    click_button 'Like Post'
    expect(page).to have_content('Likes: 1')
  end

  it 'I can see the username of each commentor.' do
    expect(page).to have_content('John Doe: This is my first comment!')
  end

  it 'I can see the comment each commentor left.' do
    expect(page).to have_content('John Doe: This is my first comment!')
  end
end
