require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) do
    User.create(email: "BillyBlogger@blog.com")
  end

  let(:user2) do
    User.create(email: "Bella_the_Blogger@blog.com")
  end

  let(:blog) do
    Blog.create(title: "Blogging Blues", body: "I love the color blue and blogging!", author_id: user.id)
  end

  describe "POST /comments (#create)" do
    context "with valid params" do
      it "redirects to the blog's show page after a comment is created" do
        post comments_url, params: {
          comment: {
            body: "I also like blue!",
            author_id: user2.id,
            blog_id: blog.id
          }
        }
        expect(Comment.exists?(body: "I also like blue!")).to be true
        expect(response).to redirect_to(blog_url(blog.id))
      end
    end

    context "with invalid params" do
      it "redirects to the blog's show page if comment is NOT created" do
        post comments_url, params: {
          comment: {
            body: "",
            author_id: user.id,
            blog_id: blog.id
          }
        }
        expect(Comment.exists?(body: "")).to be false
        expect(response).to redirect_to(blog_url(blog.id))
      end
    end
  end

  describe "DELETE /comments/:id (#destroy)" do
    it "removes the comment from the database and redirects to the blog's show page" do
      comment = Comment.create!(body: "i do not like blogging", author_id: user2.id, blog_id: blog.id)
      delete comment_url(comment), params: { id: comment.id }
      expect(Comment.exists?(comment.id)).to be false
      expect(response).to redirect_to(blog_url(blog.id))
    end
  end
end
