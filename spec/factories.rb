FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "mhartl@example.com"
    password "123456"
    password_confirmation "123456"
  end
end