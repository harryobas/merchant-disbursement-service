class DisbursementsController < ApplicationController
    def search
        if params[:id].present?
            merchant = Merchant.find_by!(id: params[:id]) 
            week = params[:week].to_i
            disbursements = DisbursementQueryProcessor(merchant, week)
            json_response(disbursements)
        else
            disbursements = DisbursementQueryProcessor(params[:week].to_i)
            json_response(disbursements)
        end
        

       
    end
end
