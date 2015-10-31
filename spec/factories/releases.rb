FactoryGirl.define do
  factory :release do
    proxy
    user
    config({'endpoint' => 'foo'}.to_yaml)
  end
end
