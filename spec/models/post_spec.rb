# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  topic_id   :integer
#  image      :string
#  rank       :float
#

include TestFactories

 require 'rails_helper'
 
 describe Post do
   describe "vote methods" do
     before do
        @post = associated_post

       3.times { @post.votes.create(value: 1) }
       2.times { @post.votes.create(value: -1) }

     end
 
     describe '#up_votes' do
       it "counts the number of votes with value = 1" do
         expect( @post.up_votes ).to eq(3)

         puts "expected: 3"
         puts "got #{@post.up_votes}"
       end
     end
 
     describe '#down_votes' do
       it "counts the number of votes with value = -1" do
         expect( @post.down_votes ).to eq(2)

         puts "expected: 2"
         puts "got #{@post.down_votes}"
       end
     end
 
     describe '#points' do
       it "returns the sum of all down and up votes" do
         expect( @post.points ).to eq(1) # 3 - 2

         puts "expected: 1"
         puts "got #{@post.points}"
       end
     end

    describe '#create_vote' do
      it "generates an up-vote when explicity called" do
        @post = associated_post
        expect( @post.up_votes ).to eq(0)
        puts "expected: 0, got: #{@post.up_votes}"
        
        @post.create_vote
        expect( @post.up_votes ).to eq(1)

        puts "expected: 1, got: #{@post.up_votes}"
      end
    end
   end
 end
