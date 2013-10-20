# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    network_id 1
    message "MyText"
    updated_time "2013-10-15"
    created_time "2013-10-15"
    user_id 1
  end
end
