FactoryBot.define do
  factory :task do
    title { 'test_title' }
    deadline { 'test_deadline' }
    priority { 'test_priority' }
    content { 'test_content' }
  end
end