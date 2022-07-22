# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{name: "kento", email: "sample@sample.com", password: "12345678", admin: true},
              {name: "門脇", email: "sample2@sample.com", password: "12345678" },
              {name: "永島", email: "sample3@sample.com", password: "12345678"},
              {name: "貝塚", email: "sample4@sample.com", password: "12345678"},
              {name: "五十嵐", email: "sample5@sample.com", password: "12345678"},
              {name: "黄昏", email: "sample6@sample.com", password: "12345678"},
              {name: "アーニャ", email: "sample7@sample.com", password: "12345678"},
              {name: "いばら姫", email: "sample8@sample.com", password: "12345678"},
              {name: "茂野", email: "sample9@sample.com", password: "12345678"},
              {name: "林", email: "sample10@sample.com", password: "12345678"},
              {name: "池田", email: "sample11@sample.com", password: "12345678"},
              {name: "福田", email: "sample12@sample.com", password: "12345678"},
              {name: "石川", email: "sample13@sample.com", password: "12345678"}])

10.times do |i|
  Label.create(name: "label#{i + 1}")
end

10.times do |i|
  Task.create([
    title: "task#{i + 1}",
    content: "content#{i + 1}",
    deadline: DateTime.now,
    status: rand(1..3),
    priority: rand(1..3),
    user_id: "#{i + 1}"
  ])
end