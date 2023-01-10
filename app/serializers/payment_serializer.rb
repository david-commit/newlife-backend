class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :business_short_code, :password, :transaction_type, :party_A, :party_B, :phone_number, :callback_url, :account_reference, :transaction_desc, :amount
end
