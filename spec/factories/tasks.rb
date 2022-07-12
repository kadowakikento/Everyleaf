FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    deadline { "2022-07-31" }
    status { '未着手' }
    priority { '低' }
    content { 'test_content1' }
  end

  factory :second_task, class: Task do
    title { 'test_title2' }
    deadline { "2022-07-31" }
    status { '未着手' }
    priority { '低' }
    content { 'test_content2' }
  end
end