require 'faker'
FactoryBot.define do
    factory :disbursement do
      fee Faker::Number.decimal(r_digits: 2)
      association merchant
      amoumt Faker::Number.decimal(r_digits: 2)
      week Faker::Number.within(range: 1..52)

    end
  end