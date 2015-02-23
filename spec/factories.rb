FactoryGirl.define do
  factory :check_in do
    task
    note { Faker::Lorem.sentence(1) }
  end

  factory :user do
    ignore do
      count { User.count + 1 }
    end

    email { "user.#{count}@example.com" }
    password 'password'
  end

  factory :task do
    user
    color 'green'
    name { "#{Faker::Company.name}" + ' Task' }
    repeat_by { 5 }
    task_type 'one_off'
    description { Faker::Lorem.sentence(1) }
  end
end
