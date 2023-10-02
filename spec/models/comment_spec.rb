# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  author_id  :bigint           not null
#  blog_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:body) }
  it { should belong_to(:author).class_name(:User) }
  it { should belong_to(:blog).class_name(:Blog) }

  describe "Foreign key constraints and indexes" do
    it "has a foreign key constraint and index on `author_id`" do
      schema = File.read('db/schema.rb')

      expect(/add_foreign_key \"comments\", \"users\", column: \"author_id\"/ =~ schema).not_to be(nil)
      expect(ActiveRecord::Base.connection.index_exists?(:comments, :author_id)).to be(true)
    end

    it "has a foreign key constraint and index on `blog_id`" do
      schema = File.read('db/schema.rb')

      expect(/add_foreign_key \"comments\", \"blogs\"/ =~ schema).not_to be(nil)
      expect(ActiveRecord::Base.connection.index_exists?(:comments, :blog_id)).to be(true)
    end
  end
end