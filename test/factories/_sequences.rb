FactoryGirl.define do
  #user
  sequence(:email)      { |n| "email#{n}@example.com" }
end
