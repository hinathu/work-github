class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @user = current_customer
    @order = Order.new
    @addresses = @user.addresses
    @myaddress = @user.postal_code + @user.address + @user.last_name + @user.first_name
  end


  def comfirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @payment_method = params[:order][:payment_method]
    select_address = params[:order][:select]
    if select_address == '0'
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
    elsif select_address == '1'
      @address = Address.find(params[:order][:address_id])
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name
    else
    end


   # 注文商品の詳細
    @cart_item = current_customer.cart_items.all
    current_customer.cart_items.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart.item.id
      @order_detail.quantity = cart.amount
    end

    # 注文商品合計金額
    @amount = 800 #①送料
    @total = @cart_item.inject(0) { |sum, item| sum + item.subtotal } #②商品合計金額

  end

  def create
    @cart_item = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    @order.order_status = 0
    if @order.save!
      current_customer.cart_items.each do |cart|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart.item.id
        @order_detail.quantity = cart.amount
        @order_detail.item_status = 0
        @order_detail.save!
      end
      redirect_to complete_path
      @cart_item.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

# 登録データのストロングパラメータ
  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_address, :shipping_name, :amount, :payment_method, :payment, :order_status)
  end

end
