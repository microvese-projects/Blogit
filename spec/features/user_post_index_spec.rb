require 'rails_helper'

describe '#' do
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
    visit user_posts_path(user)
  end

  after(:each) do
    Like.destroy_all
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content('John Doe')
  end

  it 'I can see the user\'s profile picture' do
    expect(page).to have_css('img[src="url"]')
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content('Number of posts: 4')
  end

  it 'I can see a post\'s title.' do
    expect(page).to have_content('First post')
  end

  it 'I can see some of the post\'s body.' do
    expect(page).to have_content('This is my first post')
  end

  it 'I can see the first comments on a post.' do
    expect(page).to have_content('This is my first comment!')
  end

  it 'I can see how many comments a post has.' do
    expect(page).to have_content('Comments: 2')
  end

  it 'I can see how many likes a post has.' do
    expect(page).to have_content('Likes: 0')
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content('Pagination')
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    click_link 'First post'
    expect(current_path).to eq(user_post_path(user, posts[0]))
  end
end
