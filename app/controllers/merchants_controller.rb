class MerchantsController < ApplicationController
    def disburse
        merchant = Merchant.find_by!(id: params[:id])
        if MerchantDisbursementsGenerator.generate_disbursements(merchant, params[:week].to_i)
            head :no_content
        else
            json_response({error: "disbursement rule(s) violated"}, :unprocessable_entity)
        end
    end
end
