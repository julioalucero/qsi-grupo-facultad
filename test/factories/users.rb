# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                  'John'
    provider              'facebook'
    uid                   '32093203920'
    email                 { generate(:email) }
    password              'password'
    password_confirmation 'password'
  end
end
