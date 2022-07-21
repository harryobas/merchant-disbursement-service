require 'rails_helper'

RSpec.describe DisbursementQueryProcessor do
    describe ".get_merchant_disbursements" do
        context "merchant and week present" do 
            it "returns merchant disbursements" do 
                merchant = double
                week = 4
                disbursements = double
                disbursement = double
                time = double

                allow(merchant).to receive(:present?).and_return(true)
                allow(merchant).to receive(:disbursement).and_return(disbursements)
                allow(disbursements).to receive(:select).and_yield(disbursement)
                allow(disbursement).to receive(:week)
                

                DisbursementQueryProcessor.get_merchant_disbursements(merchant, week)
            end
        end
        context "merchant is not present" do 
            it "returns all disbursements" do
                week = 4 
                merchant = double

                allow(merchant).to receive(:present?).and_return(false)
                expect(Disbursement).to receive(:where).with(week: week)

                DisbursementQueryProcessor.get_merchant_disbursements(merchant, week)
            end
        end
    end
end