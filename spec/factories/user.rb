FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com"}
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
    email_favorites true
  end

  # factory :user_other do
  #   name "Doug Adams"
  #   sequence(:email, 100) { |n| "person#{n}@example.com"}
  #   password "helloworld"
  #   password_confirmation "helloworld"
  #   confirmed_at Time.now
  # end
end