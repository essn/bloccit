require 'rails_helper'

describe Comment do

  

  describe "after_create" do

    before do

      @post = create(:post)
      @user = create(:user)
      @user_other = create(:user)
      puts "in before"
      @comment = create(:comment, post: @post, user_id: @user_other.id)
      # @post = FactoryGirl.create(:post)
      # @user = FactoryGirl.create(:user)
      # puts @user.id

      

      # puts @user_other.id
      # @comment = FactoryGirl.create(:comment, user: @user_other, post: @post)
    end

     # We don't need to change anything for this condition;
     # The email_favorites attribute defaults to true
     context "with user's permission" do

      it "sends an email to users who have favorited the post" do

        puts "in first test"
        # @comment = create(:comment, user: @user_other, post: @post)
        # @user.favorites.where(post: @post).create
        @fav = Favorite.new(user_id: @user.id, post_id: @post.id)
        @fav.save!

        puts "hello again"
        puts "here is the posts first favorite #{@fav.post_id} #{@post.id}"


        allow( FavoriteMailer )
          .to receive(:new_comment)
          .with(@user, @post, @comment)
          .and_return( double(deliver: true) )

        # expect(Comment)
        #    .to receive(:create)

        #    @comment =
        # Comment.create(:comment, user: @user_other, post: @post)
        expect( FavoriteMailer )
          .to receive(:new_comment)
        # puts "hello"
        @comment2 = create(:comment, post: @post, user_id: @user_other.id)
        
        # @comment2 = Comment.new(body: 'My body', user: @user_other, post: @post)
        # @comment2.save!
      end


      it "does not send emails to users who haven't" do
        expect( FavoriteMailer )
          .not_to receive(:new_comment)

        @comment.save
      end

    it "does not send emails to users who haven't" do
      expect( FavoriteMailer )
        .not_to receive(:new_comment)

      @comment.save
    end
  end

     context "without permission" do

       before { @user.update_attribute(:email_favorites, false) }
 
       it "does not send emails, even to users who have favorited" do


         @user.favorites.where(post: @post).create
         
         expect( FavoriteMailer )
           .not_to receive(:new_comment)

         
         
         @comment.save
       end
     end
  end
end
