require 'timecop'

def create_merchants()
    merchant_file = File.read(Rails.root.join('merchants.json'))
    hash = JSON.parse(merchant_file)

    merchants_list = hash['RECORDS']

    merchants_list.each do |merchant|

        m = Merchant.new
        m.id = merchant['id']
        m.name = merchant['name']
        m.email = merchant['email']
        m.cif = merchant['cif']
        m.save
    end  
end

def create_shoppers()
    shopper_file = File.read(Rails.root.join('shoppers.json'))
    hash = JSON.parse(shopper_file)

    shoppers_list = hash['RECORDS']

    shoppers_list.each do |shopper|
        s = Shopper.new
        s.id = shopper['id']
        s.name = shopper['name']
        s.email = shopper['email']
        s.nif = shopper['nif']
        s.save
    end
end

def create_orders()
    order_file = File.read(Rails.root.join('orders.json'))
    hash = JSON.parse(order_file)

    orders_list = hash['RECORDS']

    orders_list.each do |order|
        o = Order.new
        o.id = order['id']
        o.amount = order['amount']
        o.merchant_id = order['merchant_id']
        o.shopper_id = order['shopper_id']
        o.completed_at = order['completed_at']
        o.created_at = order['created_at']
        o.save
    end
end

def create_disbursements()
    Merchant.all.each do |m|
        Timecop.travel(Time.parse("2022-07-18 04:17:36")) do 
            week = rand(1..52)
            MerchantDisbursementsGenerator.generate_disbursements(m, week)
        end
    end
end


create_merchants
create_shoppers
create_orders
create_disbursements



