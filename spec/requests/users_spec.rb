require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject(:user) do
    User.create(email: "BellaBlogsItAll@blog.com")
  end

  describe "GET /users/:id (#show)" do
    it "renders the show template and sets an @user variable for the Blog matching the params id" do
      get user_url(user), params: { id: user.id }
      expect(response.body).to include("Hello BellaBlogsItAll@blog.com!")
    end
  end

  describe "POST /users (#create)" do
    context "with valid params" do
      it "redirects to the blog index page after a user is created" do
        post users_url, params: {
          user: {
            email: "blogging@blog.com"
          }
        }
        expect(User.exists?(email: "blogging@blog.com")).to be true
        expect(response).to redirect_to(blogs_url)
      end
    end

    context "with invalid params" do
      it "renders the new template if a user cannot be created" do
        post users_url, params: {
          user: {
            email: ""
          }
        }
        expect(User.exists?(email: "")).to be false
        expect(response.body).to include("Create a new User!")
      end
    end
  end
end
