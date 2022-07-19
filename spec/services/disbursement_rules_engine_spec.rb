require 'rails_helper'

RSpec.describe DisbursementRulesEngine do
    before(:each) do
        @order = double
        @complete = double 
        @time = double
    end
    describe ".check_disbursement_rules" do 
        context "order status is complete and week day is monday" do
            it "returns true" do 

                allow(@order).to receive(:completed_at).and_return(@complete)
                allow(@complete).to receive(:present?).and_return(true)
                allow(Time).to receive(:now).and_return(@time)
                allow(@time).to receive(:monday?).and_return(true)

                expect(DisbursementRulesEngine.check_disbursement_rules(Time, @order))
                .to eq true
            end
        end
        context "order status is complete and week day is not monday" do
            it "returns false" do
                allow(@order).to receive(:completed_at).and_return(@complete)
                allow(@complete).to receive(:present?).and_return(true)
                allow(Time).to receive(:now).and_return(@time)
                allow(@time).to receive(:monday?).and_return(false)

                expect(DisbursementRulesEngine.check_disbursement_rules(Time, @order))
                .to eq false
            end
        end
        context "order status is not complete and week day is monday" do 
            it "returns false" do 
                allow(@order).to receive(:completed_at).and_return(@complete)
                allow(@complete).to receive(:present?).and_return(false)
                allow(Time).to receive(:now).and_return(@time)
                allow(@time).to receive(:monday?).and_return(true)

                expect(DisbursementRulesEngine.check_disbursement_rules(Time, @order))
                .to eq false
            end
        end
        context "order status is not complete and week day is not monday" do 
            it "returns false" do 
                allow(@order).to receive(:completed_at).and_return(@complete)
                allow(@complete).to receive(:present?).and_return(false)
                allow(Time).to receive(:now).and_return(@time)
                allow(@time).to receive(:monday?).and_return(false)

                expect(DisbursementRulesEngine.check_disbursement_rules(Time, @order))
                .to eq false
            end
        end
    end

end