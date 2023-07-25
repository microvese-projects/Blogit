require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    it 'gets the index page' do
      get '/users/:user_id/posts'
      expect(response.status).to eq(200)
      expect(response.content_type).to match(a_string_including('text/html'))
      expect(response.body).to match(a_string_including('This page lists all posts of a certain user'))
    end
  end

  describe 'GET /show' do
    it 'gets a specific post with id' do
      get '/users/:user_id/posts/:id'
      expect(response.status).to eq(200)
      expect(response.content_type).to match(a_string_including('text/html'))
      expect(response.body).to match(a_string_including('This page shows details of a specific post'))
    end
  end
end
