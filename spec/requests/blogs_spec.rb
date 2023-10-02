require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user) do
    User.create!(email: "LivesToBlog@blog.com")
  end

  subject(:blog) do
    Blog.create!(title: "Blog 1 - Good Day", body: "today was good", author_id: user.id)
  end

  let(:blog2) do
    Blog.create!(title: "Blog 2 - Better Day", body: "today was great!", author_id: user.id)
  end

  describe "GET /blogs (#index)" do
    it "renders the index template and sets an @blogs variable for all Blogs in the database" do
      #  creating two blogs in the test database
      blog
      blog2
      get blogs_url
      expect(response.body).to include("Blog 1 - Good Day")
      expect(response.body).to include("Blog 2 - Better Day")
    end
  end

  describe "GET /blogs/:id (#show)" do
    it "renders the show template and sets an @blog variable for the Blog matching the params id" do
      get blog_url(blog), params: { id: blog.id }
      expect(response.body).to include("Blog 1 - Good Day")
      expect(response.body).to include("today was good")
    end
  end

  describe "POST /blogs (#create)" do
    context "with valid params" do
      it "redirects to the blog's index page after a blog is created" do
        post blogs_url, params: {
          blog: {
            title: "Day 3 - BEST DAY!",
            body: "best day evar",
            author_id: user.id
          }
        }
        expect(Blog.exists?(title: "Day 3 - BEST DAY!")).to be true
        expect(response).to redirect_to(blogs_url)
      end
    end

    context "with invalid params" do
      it "renders the new template if a blog does not NOT save to the database" do
        post blogs_url, params: {
          blog: {
            title: "blank blank",
            body: "",
            author_id: user.id
          }
        }
        expect(Blog.exists?(title: "blank blank")).to be false
        expect(response.body).to include("Create a new Blog!")
      end
    end
  end
end