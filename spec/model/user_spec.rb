require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "John Doe", photo: 'url', bio: 'This is a bio test')}
  before {subject.save}

  it 'name cannot be nil' do
    expect(subject).to be_valid
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer greater than or equal to zero' do
    expect(subject.posts_counter.to_i).to be == 0
    Post.create(author: subject, title: 'Post 1', text: 'THis is the first post.')
    expect(subject.posts_counter).to be > 0
  end
end