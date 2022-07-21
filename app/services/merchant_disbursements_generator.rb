class MerchantDisbursementsGenerator

    class << self
        def generate_disbursements(merchant, week)
            valid_week = !(week<=0)  
            raise StandardError, 'invalid week' unless valid_week

            merchant_orders = merchant.order

            if merchant_orders.size == 0
                raise StandardError, "no order(s) to disburse for merchant"
            end

            if merchant.disbursement.any?{|d| d.week == week}
                raise StandardError, "disbursements already processed for week: #{week}"
            end

            disbursement_orders = merchant_orders
            .select{|order| DisbursementRulesEngine.check_disbursement_rules(Time, order)}

            if disbursement_orders.size > 0
                disbursement_orders
                .map{|order| compute_disbursement(order, merchant, week) }
                .each{|d| d.save!} 
                return  true
            else
                return false
            end
        rescue ActiveRecord::RecordInvalid
        end 

        private

        def compute_disbursement(order, merchant, week)
            fee, amount = calculate_fee_and_disbursement(order)
            
            disbursement = Disbursement.new

            disbursement.fee = fee
            disbursement.amount = amount 
            disbursement.week = week
            disbursement.merchant_id = merchant.id 

            disbursement
        end

        def calculate_fee_and_disbursement(order)
            fee = (1.to_d/100.to_d)*order.amount if order.amount < 50.to_d
            fee = (0.85.to_d/100.to_d)*order.amount if order.amount > 300.to_d
            fee = (0.95.to_d/100.to_d)*order.amount if order.amount >= 50.to_d && order.amount <= 300.to_d

            disbursed_amt = order.amount-fee

            [fee, disbursed_amt] 

        end
    end
    
end

