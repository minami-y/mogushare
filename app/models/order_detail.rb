class OrderDetail < ApplicationRecord
  belongs_to :share
  belongs_to :order, optional: true
end
