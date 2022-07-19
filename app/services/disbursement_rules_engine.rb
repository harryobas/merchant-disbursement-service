class DisbursementRulesEngine
    def self.check_disbursement_rules(time, order)
        time.now.monday? && order.completed_at.present?
    end
end