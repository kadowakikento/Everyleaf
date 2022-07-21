FactoryBot.define do
  factory :label do
    name { "test_01" }
  end

  factory :second_label, class: Label do
    name { "test_02" }
  end

  factory :third_label, class: Label do
    name { "test_03" }
  end
end
