class DisbursementsController < ApplicationController
    def search
        if params[:merchant_id].present?
            merchant = Merchant.find_by!(id: params[:merchant_id]) 
            week = params[:week].to_i
            disbursements = DisbursementQueryProcessor
            .get_merchant_disbursements(merchant, week)

            json_response(disbursements)
        else
            disbursements = DisbursementQueryProcessor
            .get_merchant_disbursements(params[:week].to_i)

            json_response(disbursements)
        end
          
    end
end
