class DisbursementQueryProcessor
    def self.get_merchant_disbursements(merchant=nil, week)
        if merchant.present?
            return merchant.disbursements.select{|d| d.created_at.strftime('%-V') == week}    
        end

        Disbursement.where(week: week)
    end
end