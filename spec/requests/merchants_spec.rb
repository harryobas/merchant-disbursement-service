require 'rails_helper'
require 'faker'

RSpec.describe "Merchants", type: :request do
  before(:each) do
    @params = {week: 5}
  end
  describe "POST /merchants/:id/disburse" do
    context "week day is monday and merchant has order(s) with status complete" do
      it "returns status code 204 with empty response body" do

        merchant =  Merchant.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          cif: Faker::Alphanumeric.alphanumeric(number: 10)
          )

        shopper =  Shopper.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          nif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
        order =  Order.create(
          amount: Faker::Number.decimal(r_digits: 2),
          completed_at: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now),
          merchant_id: merchant.id, 
          shopper_id: shopper.id  
          )
       
        Timecop.travel(Time.parse("2022-07-18 04:17:36")) do 
          post "/merchants/#{merchant.id}/disburse", params: @params
          expect(response).to have_http_status(204)
          expect(response.body).to be_empty
        end
      end
    end
    context "week day is not monday and merchant has order(s) with status complete" do
      it "returns error with status code 422" do
        merchant =  Merchant.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          cif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          shopper =  Shopper.create(
            name: Faker::Company.name,
            email: Faker::Internet.email,
            nif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          order =  Order.create(
            amount: Faker::Number.decimal(r_digits: 2),
            completed_at: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now),
            merchant_id: merchant.id, 
            shopper_id: shopper.id  
          )
        post "/merchants/#{merchant.id}/disburse", params: @params
        expect(JSON.parse(response.body)['error']).to eq 'disbursement rule(s) violated'
        expect(response).to have_http_status(422)
      end
    end
    context "week day is monday and merchant has no order(s) with status complete" do
      it "returns error with status code 422" do
        merchant =  Merchant.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          cif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          shopper =  Shopper.create(
            name: Faker::Company.name,
            email: Faker::Internet.email,
            nif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          order =  Order.create(
            amount: Faker::Number.decimal(r_digits: 2),
            completed_at: nil,
            merchant_id: merchant.id, 
            shopper_id: shopper.id  
          ) 
          
          Timecop.travel(Time.parse("2022-07-18 04:17:36")) do 
            post "/merchants/#{merchant.id}/disburse", params: @params
            expect(JSON.parse(response.body)['error']).to eq 'disbursement rule(s) violated'
            expect(response).to have_http_status(422)
          end
      end
    end
    context "week day is not monday and merchant has no order(s) with ststus complete" do
      it "returns error with status code 422" do
        merchant =  Merchant.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          cif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          shopper =  Shopper.create(
            name: Faker::Company.name,
            email: Faker::Internet.email,
            nif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          order =  Order.create(
            amount: Faker::Number.decimal(r_digits: 2),
            completed_at: nil,
            merchant_id: merchant.id, 
            shopper_id: shopper.id  
          ) 
          post "/merchants/#{merchant.id}/disburse", params: @params
          expect(JSON.parse(response.body)['error']).to eq 'disbursement rule(s) violated'
          expect(response).to have_http_status(422)
      end 
    end 
    context "week == 0" do
      it "returns error with status code 422" do 
        params = {week: 0}
        merchant =  Merchant.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          cif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          shopper =  Shopper.create(
            name: Faker::Company.name,
            email: Faker::Internet.email,
            nif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          order =  Order.create(
            amount: Faker::Number.decimal(r_digits: 2),
            completed_at: nil,
            merchant_id: merchant.id, 
            shopper_id: shopper.id  
          ) 
          post "/merchants/#{merchant.id}/disburse", params: params
          expect(JSON.parse(response.body)['error']).to eq 'invalid week'
          expect(response).to have_http_status(422)
      end
    end
    context "week < 0" do
      it "returns error with status code 422" do
        params = {week: -1}
        merchant =  Merchant.create(
          name: Faker::Company.name,
          email: Faker::Internet.email,
          cif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          shopper =  Shopper.create(
            name: Faker::Company.name,
            email: Faker::Internet.email,
            nif: Faker::Alphanumeric.alphanumeric(number: 10)
          )
          order =  Order.create(
            amount: Faker::Number.decimal(r_digits: 2),
            completed_at: nil,
            merchant_id: merchant.id, 
            shopper_id: shopper.id  
          ) 
          post "/merchants/#{merchant.id}/disburse", params: params
          expect(JSON.parse(response.body)['error']).to eq 'invalid week'
          expect(response).to have_http_status(422) 
      end
    end
    context "merchant does not have any orders" do
      it "returns error with ststus code 422" do
      params = {week: 2}
      merchant =  Merchant.create(
      name: Faker::Company.name,
      email: Faker::Internet.email,
      cif: Faker::Alphanumeric.alphanumeric(number: 10)
      )
      post "/merchants/#{merchant.id}/disburse", params: params
      expect(JSON.parse(response.body)['error']).to eq "no order(s) to disburse for merchant"
      expect(response).to have_http_status(422)
      end 
    end
    context "merchant already have disbursement(s) for given week" do
      it "returns error with status code 422" do
        merchant =  Merchant.create(
        name: Faker::Company.name,
        email: Faker::Internet.email,
        cif: Faker::Alphanumeric.alphanumeric(number: 10)
      )
      shopper =  Shopper.create(
        name: Faker::Company.name,
        email: Faker::Internet.email,
        nif: Faker::Alphanumeric.alphanumeric(number: 10)
      )
      order =  Order.create(
        amount: Faker::Number.decimal(r_digits: 2),
        completed_at: nil,
        merchant_id: merchant.id, 
        shopper_id: shopper.id  
      ) 
      disbursement = Disbursement.create(
        fee: Faker::Number.decimal(r_digits: 2),
        amount: Faker::Number.decimal(r_digits: 2),
        week: 10,
        merchant_id: merchant.id 
      )

      params = {week: disbursement.week}

      post "/merchants/#{merchant.id}/disburse", params: params
      expect(JSON.parse(response.body)['error']).to eq "disbursements already processed for week: #{params[:week]}"
      expect(response).to have_http_status(422)

      end
    end
  end
end
