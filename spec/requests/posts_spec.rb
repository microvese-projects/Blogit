require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      user = User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test')
      post = Post.create(author: user, title: 'First post', text: 'This is my first post')

      get "/users/#{user.id}/posts"
    end

    it 'Should successfully get all posts' do
      expect(response.status).to eq(200)
    end

    it 'Should successfully render a list of posts' do
      expect(response.body).to match(a_string_including('This is my first post'))
    end

    it 'Should render HTML' do
      expect(response.content_type).to match(a_string_including('text/html'))
    end
  end

  describe 'GET /show' do
    before(:each) do
      user = User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test')
      post = Post.create(author: user, title: 'First post', text: 'This is my first post')

      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'gets a specific post with id' do
      expect(response.status).to eq(200)
    end

    it 'Should successfully render details of a post' do
      expect(response.body).to match(a_string_including('This is my first post'))
    end

    it 'Should render HTML' do
      expect(response.content_type).to match(a_string_including('text/html'))
    end
  end
end
