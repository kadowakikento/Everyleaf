FactoryBot.define do
  factory :user do
    id { "0" }
    name { "test_name" }
    email { "test@test.com" }
    password { "12345678" }
    password_confirmation { "12345678"}
    admin { false }
  end
  factory :second_user, class: User do
    id { "1" }
    name { "second_name" }
    email { "second@second.com" }
    password { "12345678" }
    password_confirmation { "12345678"}
    admin { true }
  end
  factory :third_user, class: User do
    id { "2" }
    name { "third_name" }
    email { "third@third.com" }
    password { "12345678" }
    password_confirmation { "12345678"}
    admin { true }
  end
end
