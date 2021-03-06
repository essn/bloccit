 require 'faker'
 
 # Create Users
 5.times do
   user = User.new(
     name:     Faker::Name.name,
     email:    Faker::Internet.email,
     password: Faker::Lorem.characters(10)
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all

 # Create Topics
 50.times do
   Topic.create!(
     name:         Faker::Lorem.sentence,
     description:  Faker::Lorem.paragraph
   )
 end
 topics = Topic.all
 
 # Note: by calling `User.new` instead of `create`,
 # we create an instance of User which isn't immediately saved to the database.
 
 # The `skip_confirmation!` method sets the `confirmed_at` attribute
 # to avoid triggering an confirmation email when the User is saved.
 
 # The `save` method then saves this User to the database.


# Create Posts
50.times do
   post = Post.create!(
    user:   users.sample,
    topic:  topics.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )

   # set the created_at to a time within the past year
   post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
   post.create_vote
   post.update_rank
end
posts = Post.all
 
 # Create Comments
 100.times do
   Comment.create!(
     user: users.sample, # we have not yet associated Users with Comments
     post: posts.sample,
     body: Faker::Lorem.paragraph
   )
 end
 
 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"


admin = User.new(
  name: 'Admin User',
  email: 'admin@admin.admin',
  password: 'adminadmin',
  role: 'password'
)

admin.skip_confirmation!
admin.save!

moderator = User.new(
  name: 'Moderator User',
  email: 'moderator@moderator.moderator',
  password: 'moderator',
  role: 'password'
  )

moderator.skip_confirmation!
moderator.save!

member = User.new(
  name: 'User User',
  email: 'user@user.user',
  password: 'password'
)

member.skip_confirmation!
member.save!

test_delete = User.new(
  name: 'Delete me!',
  email: 'delete@delete.delete',
  password: 'password'
)

me = User.new(
  name: 'Jesse Pledger',
  email: "jessepledger@gmail.com",
  password: 'password',
  role: 'admin'
)

me.skip_confirmation!
me.save!

test_delete.skip_confirmation!
test_delete.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"