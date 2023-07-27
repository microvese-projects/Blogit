require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    before(:each) do
      user = User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test')
      Post.create(author: user, title: 'First post', text: 'This is my first post')

      get '/users'
    end

    it 'Should succesfully get a list of all users' do
      expect(response.status).to eq(200)
    end

    it 'Should list all users' do
      expect(response.body).to match(a_string_including('John Doe'))
    end
  end

  describe 'GET /show' do
    before(:each) do
      user = User.create(name: 'John Doe', photo: 'url', bio: 'This is a bio test')
      Post.create(author: user, title: 'First post', text: 'This is my first post')

      get "/users/#{user.id}"
    end

    it 'Should succesfully fetch a user\'s profile' do
      expect(response.status).to eq(200)
    end

    it 'Should return html' do
      expect(response.content_type).to match(a_string_including('text/html'))
    end

    it 'Should display the user\s data' do
      expect(response.body).to match(a_string_including('This is my first post'))
    end
  end
end
