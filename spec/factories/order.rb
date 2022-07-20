require 'faker'

FactoryBot.define do
    factory :order do
      amount {Faker::Number.decimal(r_digits: 2)}
      association merchant
      completed_at {Faker::Time.between(from: DateTime.now - 10, to: DateTime.now)}
    end
  end