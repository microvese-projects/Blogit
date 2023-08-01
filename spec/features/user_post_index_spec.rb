require 'rails_helper'

describe 'posts page' do
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

  before { visit user_posts_path(user) }

  context 'shows details' do
    it 'on the user' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_css('img[src="url"]')
    end
  end

  context 'shows details on all posts' do
    it '# first post' do
      expect(page).to have_content('First post')
      expect(page).to have_content('This is my first post')
    end
    it '# second post' do
      expect(page).to have_content('Second post')
      expect(page).to have_content('This is my second post')
    end
    it '# third post' do
      expect(page).to have_content('Third post')
      expect(page).to have_content('This is my third post')
    end
    it '# fourth post' do
      expect(page).to have_content('Fourth post')
      expect(page).to have_content('This is my fourth post')
    end
  end

  context 'shows details' do
    describe 'on the latest comments' do
      it 'updating comments counter' do
        expect(page).to have_content('Comments: 2')
        expect(page).to have_content('Likes: 0')
      end

      it '# first comment' do
        expect(page).to have_content('This is my first comment!')
      end

      it '# second comment' do
        expect(page).to have_content('This is my second comment!')
      end
    end
  end

  context 'visits the post details page on clicking a post' do
    before { click_link 'First post' }
    it 'shows only the details of the first post' do
      expect(page).to have_content('First post')
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my first comment')
      expect(page).to have_content('This is my second comment')
      expect(page).to have_content('Comments: 2')
      expect(page).to have_content('Likes: 0')
      expect(page).to_not have_content('Second post')
    end
  end
end
