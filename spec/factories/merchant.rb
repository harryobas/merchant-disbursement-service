require 'faker'
FactoryBot.define do
    factory :merchant do
      name Faker::Company.name
      email Faker::Internet.email
      cif Faker::Alphanumeric.alphanumeric(number: 10)
    end
  end