class Merchant < ApplicationRecord
    has_many :order
    has_many :disbursement
end
