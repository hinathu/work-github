class Admin::OrderController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])

    if @order.update(order_params)
      # ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
      @order_details.update_all(item_status: 1) if @order.order_status == "payment_confirmation"
    end
    redirect_to admin_order_path(@order)
  end



private

def order_params
  params.require(:order).permit(:order_status)
end

end
