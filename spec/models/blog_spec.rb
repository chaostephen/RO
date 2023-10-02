# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  body       :text             not null
#  author_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { User.create(email: "bloggerboi@fakeblog.com") }
  subject { Blog.create(title: "Let me tell you about that one time", body: "It was cool", author_id: user.id) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_uniqueness_of(:title).scoped_to(:author_id) }
  it { should belong_to(:author).class_name(:User) }
  it { should have_many(:comments).class_name(:Comment) }

  it "has a foreign key constraint and (exactly one) index for `author_id`" do
    schema = File.read('db/schema.rb')

    expect(/add_foreign_key \"blogs\", \"users\", column: \"author_id\"/ =~ schema).not_to be(nil)
    expect(ActiveRecord::Base.connection.index_exists?(:blogs, [:author_id, :title])).to be(true)
    expect(ActiveRecord::Base.connection.index_exists?(:blogs, :author_id)).to be(false)
  end

  it "can be successfully destroyed" do
    Comment.create!(body: "Body", author_id: user.id, blog_id: subject.id)
    expect { subject.destroy }.not_to raise_error
  end
end