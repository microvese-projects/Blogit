require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/users/:user_id/posts'
    end

    it 'Should succesfully get all posts' do
      expect(response.status).to eq(200)
    end

    it 'Should succesfully render a list of posts' do
      expect(response.body).to match(a_string_including('This page lists all posts of a certain user'))
    end

    it 'Should render Html' do
      expect(response.content_type).to match(a_string_including('text/html'))
    end
  end

  describe 'GET /show' do
    before(:each) do
      get '/users/:user_id/posts/:id'
    end

    it 'gets a specific post with id' do
      expect(response.status).to eq(200)
    end

    it 'Should succesfully render details of a post' do
      expect(response.body).to match(a_string_including('This page shows details of a specific post'))
    end

    it 'Should render Html' do
      expect(response.content_type).to match(a_string_including('text/html'))
    end
  end
end
