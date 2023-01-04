class Admin::OrderDetailsController < ApplicationController

before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all

    is_updated = true

    if @order_detail.update(order_detail_params)

  # ②製作ステータスが「製作中」のときに、注文ステータスを「発送準備中」に更新
      @order.update(order_status: 2) if @order_detail.item_status == "in_production"

  # ③紐付いている注文商品の製作ステータスが "すべて" [製作完了]になったとき注文ステータスを「発送準備中」に更新
      @order_details.each do |order_detail|
        if order_detail.item_status != "production_complete"
          is_updated = false
        end
      end
      @order.update(order_status: 3) if is_updated
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_status)
  end

end
