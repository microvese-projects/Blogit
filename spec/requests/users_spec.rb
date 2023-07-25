require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/users'
    end
    it 'Should succesfully get a list of all users' do
      expect(response.status).to eq(200)
    end

    it 'Should list all users' do
      expect(response.body).to match(a_string_including('This page lists all users'))
    end
  end

  describe 'GET /show' do
    before(:each) do
      get '/users/:id'
    end

    it 'Should succesfully fetch a user\'s profile' do
      expect(response.status).to eq(200)
    end

    it 'Should return html' do
      expect(response.content_type).to match(a_string_including('text/html'))
    end

    it 'Should display the user\s data' do
      expect(response.body).to match(a_string_including('renders the profile of a specific user with a given id'))
    end
  end
end
