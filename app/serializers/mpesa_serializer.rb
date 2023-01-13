class MpesaSerializer < ActiveModel::Serializer
  attributes :id, :checkoutRequestId, :merchantRequestId, :amount, :mpesaReceiptNumber, :phoneNumber
end
