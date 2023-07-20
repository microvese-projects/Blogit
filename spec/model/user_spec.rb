require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'url', bio: 'This is a bio test') }

  before do
    subject.save
    Post.create(author: subject, title: 'First post', text: 'This is my first post')
    Post.create(author: subject, title: 'second post', text: 'This is my second post')
    Post.create(author: subject, title: 'third post', text: 'This is my third post')
    Post.create(author: subject, title: 'fourth post', text: 'This is my fourth post')
  end

  it 'name cannot be nil' do
    expect(subject).to be_valid
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer greater than or equal to zero' do
    expect(subject.posts_counter).to be > 0
  end

  describe '#recent_posts' do
    it 'should return not more than three posts' do
      expect(subject.recent_posts.size).to be <= 3
    end
  end
end
