FactoryGirl.define do
  factory :proxy do
    endpoint 'http://example.com'
    user
  end
end
