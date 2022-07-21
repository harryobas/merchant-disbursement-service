class DisbursementSerializer < ActiveModel::Serializer
  attributes :id, :amount, :fee, week, merchant_id
end
