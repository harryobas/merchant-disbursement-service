require 'rails_helper'

RSpec.describe MerchantDisbursementsGenerator do
    before(:each) do
        @mock = double('merchant')
    end
    describe ".generate_disbursements" do

        it "gets merchant orders" do
        week = 3
        order = double
        disbursements = double
        disbursement = double

        allow(@mock).to receive(:disbursement).and_return(disbursements)
        allow(disbursements).to receive(:any?).and_yield(disbursement).and_return(false)
        allow(disbursement).to receive(:week)

        expect(@mock).to receive(:order).and_return([order])
        MerchantDisbursementsGenerator.generate_disbursements(@mock, week) 
        end
       
        it "raises error if week is zero" do
            expect{
                MerchantDisbursementsGenerator.generate_disbursements(@mock, 0)
        }.to raise_error(StandardError)
        end

        it "raises error if week is negative" do
            expect{
                MerchantDisbursementsGenerator.generate_disbursements(@mock, -5)
        }.to raise_error(StandardError)
        end 

        it "raises error if week > 52" do
            expect{
                MerchantDisbursementsGenerator.generate_disbursements(@mock, 55)
        }.to raise_error(StandardError)
        end

        context 'merchant orders list is empty' do
            it "raises error" do
               
                orders = double
                week = 3
                allow(@mock).to receive(:order).and_return(orders)
                allow(orders).to receive(:size).and_return(0)
                expect{
                    MerchantDisbursementsGenerator.generate_disbursements(@mock, week)
            }.to raise_error(StandardError)
            
            end
        end
        context "merchant orders list is not empty" do
            it "validates merchant orders against disbursement rules" do
                week = 3
                order = double 
                orders = double
                disbursement_orders = double
                amt = double
                disbursement = double
                disbursements = double

                allow(@mock).to receive(:order).and_return(orders)
                allow(orders).to receive(:size).and_return(1)
                allow(orders).to receive(:select).and_yield(order).and_return(disbursement_orders)
                allow(order).to receive(:amount).and_return(amt)
                allow(amt).to receive(:<)
                allow(amt).to receive(:>)
                allow(amt).to receive(:>=)
                allow(amt).to receive(:-)
                allow(disbursement_orders).to receive(:size).and_return(1)
                allow(disbursement_orders)
                .to receive(:map).and_yield(order).and_return(disbursement_orders)

                allow(@mock).to receive(:id)

                allow(@mock).to receive(:disbursement).and_return(disbursements)
                allow(disbursements).to receive(:any?).and_yield(disbursement).and_return(false)
                allow(disbursement).to receive(:week)

                allow(disbursement_orders)
                .to receive(:each).and_yield(disbursement)
                allow(disbursement).to receive(:save!)

                expect(DisbursementRulesEngine)
                .to receive(:check_disbursement_rules)
                .with(Time, order)

                MerchantDisbursementsGenerator.generate_disbursements(@mock, week)

            end
        end
        context "merchant has one or more orders validated for disbursement" do
            it "returns true" do
                week = 3
                order = double 
                orders = double
                disbursement_orders = double
                amt = double
                disbursement = double
                disbursements = double

                allow(@mock).to receive(:order).and_return(orders)
                allow(orders).to receive(:size).and_return(1)
                allow(orders).to receive(:select).and_yield(order).and_return(disbursement_orders)
                allow(order).to receive(:amount).and_return(amt)
                allow(amt).to receive(:<)
                allow(amt).to receive(:>)
                allow(amt).to receive(:>=)
                allow(amt).to receive(:-)
                allow(disbursement_orders).to receive(:size).and_return(1)
                allow(disbursement_orders)
                .to receive(:map).and_yield(order).and_return(disbursement_orders)

                allow(@mock).to receive(:id)

                allow(@mock).to receive(:disbursement).and_return(disbursements)
                allow(disbursements).to receive(:any?).and_yield(disbursement).and_return(false)
                allow(disbursement).to receive(:week)

                allow(disbursement_orders)
                .to receive(:each).and_yield(disbursement)

                allow(disbursement).to receive(:save!)

                expect(MerchantDisbursementsGenerator.generate_disbursements(@mock, week))
                .to eq true

            end
        end
        context "merchant has no order validated for disbursement" do
            it "returns false" do
                week = 3
                order = double 
                orders = double
                disbursement_orders = double
                amt = double
                disbursement = double
                disbursements = double

                allow(@mock).to receive(:order).and_return(orders)
                allow(orders).to receive(:size).and_return(1)
                allow(orders).to receive(:select).and_yield(order).and_return(disbursement_orders)
        
                allow(disbursement_orders).to receive(:size).and_return(0)

                allow(@mock).to receive(:disbursement).and_return(disbursements)
                allow(disbursements).to receive(:any?).and_yield(disbursement).and_return(false)
                allow(disbursement).to receive(:week)
    
                expect(MerchantDisbursementsGenerator.generate_disbursements(@mock, week))
                .to eq false

            end
        end
        context "merchant already has disbursement(s) for a given week" do
            it "should raise error" do
                week = 3
                orders = double
                disbursements = double
                disbursement = double

                allow(@mock).to receive(:order).and_return(orders)
                allow(orders).to receive(:size).and_return(1)

                allow(@mock).to receive(:disbursement).and_return(disbursements)
                allow(disbursements).to receive(:any?).and_yield(disbursement).and_return(true)
                allow(disbursement).to receive(:week)

                expect{
                    MerchantDisbursementsGenerator.generate_disbursements(@mock, week)
            }.to raise_error(StandardError)
            end
        end
    
    end
end
 

