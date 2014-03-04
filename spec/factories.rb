FactoryGirl.define do
  factory :user do
    ignore do
      count { User.count + 1 }
    end

    email { "user.#{count}@example.com" }
    password 'password'
  end

  factory :task do
    user
    border_color 'none'
    color 'green'
    name { "#{Faker::Company.name}" + ' Task' }
    task_type 'one_off'
    description { Faker::Lorem.sentence(1) }
  end
end