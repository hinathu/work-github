class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

# 制作ステータス (着手不可: 0, 製作待ち: 1, 制作中: 2, 制作完了:3)
enum item_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }

end
