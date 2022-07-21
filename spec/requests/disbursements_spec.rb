require 'rails_helper'
require 'faker'

RSpec.describe "Disbursements", type: :request do
  
  describe "GET /disbursements/search" do
   context "search with merchant and week" do
    it "returns merchant disbursements for given week with status code 200" do 
      merchant =  Merchant.create(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      cif: Faker::Alphanumeric.alphanumeric(number: 10)
      )
    
      disbursement_3 = Disbursement.create(
      fee: Faker::Number.decimal(r_digits: 2),
      amount: Faker::Number.decimal(r_digits: 2),
      week: 13,
      merchant_id: merchant.id 
      )
      
      params = {id: merchant.id, week: 13}
    
      get "/disbursements/search", params: params
      expect(JSON.parse(response.body).size).to eq 1
   end
  end
  context "search without merchant" do
    it "returns all disbursements for given week" do
      params = {id: "", week: 10}

      merchant =  Merchant.create(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      cif: Faker::Alphanumeric.alphanumeric(number: 10)
    )
    
     Disbursement.create(
      fee: Faker::Number.decimal(r_digits: 2),
      amount: Faker::Number.decimal(r_digits: 2),
      week: 10,
      merchant_id: merchant.id     
    )
    
      get "/disbursements/search", params: params

      expect(JSON.parse(response.body).size).to eq 1
    end
  end
end

end



