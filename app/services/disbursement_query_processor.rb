class DisbursementQueryProcessor
    def self.get_merchant_disbursements(merchant=nil, week)
        if merchant.present?
            return merchant.disbursement.select{|d| d.week == week}    
        else
            return Disbursement.where(week: week)
        end
    end
end