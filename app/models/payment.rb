class Payment < ApplicationRecord
    has_one :order
end
