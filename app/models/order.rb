class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy
  belongs_to :customer

  # 支払方法（1が入ってる時：クレジットカード、2が入ってる時：銀行振込）
  enum payment_method: { credit_card: 1, transfer: 2 }

  # 注文ステータス ( 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }
  enum order_status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

end
