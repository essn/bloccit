require 'rails_helper'

describe "Visiting profiles" do
  
  

  before do
    @user = create(:user)
    @topic = Topic.create(description: "A topic")
    @post = create(:post, user: @user)
    @comment = create(:comment, user: @user, post: @post)

    allow(@comment).to receive(:send_favorite_emails)
    @comment.save

  end

  describe "not signed in" do
    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end

  describe "signed in" do
    before do
      visit root_path

      within '.user-info' do
      click_link "Sign In"
    end

      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)

       within 'form' do
         click_link 'Sign In'
       end
      # sign_in(@user, :scope => :user)
    end

    it "shows profile" do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end
end