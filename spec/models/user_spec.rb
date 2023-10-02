# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(email: "bloggerboi@fakeblog.com") }
  
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:blogs).class_name(:Blog) }
  it { should have_many(:comments).class_name(:Comment) }
  it { should have_many(:comments_on_blogs).through(:blogs).source(:comments) }
  it { should have_many(:blogs_commented_on).through(:comments).source(:blog) }

  it "has an index on `email`" do
    expect(ActiveRecord::Base.connection.index_exists?(:users, :email)).to be(true)
  end

  it "makes sure associations are bi-directional" do
    Blog.create!(title: "Title", body: "My text!", author_id: subject.id)
    Comment.create!(body: "Comment", author_id: subject.id, blog_id: Blog.first.id)
    blog = subject.blogs.first
    comment = subject.comments.first
    expect(subject.object_id == blog.author.object_id).to be(true)
    expect(subject.object_id == comment.author.object_id).to be(true)
  end

  it "can be successfully destroyed" do
    Blog.create!(title: "Title", body: "My text!", author_id: subject.id)
    Blog.create!(title: "Title2", body: "My second text!", author_id: subject.id)
    Comment.create!(body: "Comment", author_id: subject.id, blog_id: Blog.second.id)
    expect { subject.destroy }.not_to raise_error
  end
end