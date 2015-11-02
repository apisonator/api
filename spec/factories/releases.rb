FactoryGirl.define do
  factory :release do
    proxy
    user
    config({'middleware' => [:a, :b, :c]})
  end
end
