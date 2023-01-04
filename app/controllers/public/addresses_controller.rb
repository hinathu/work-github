class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def index
    @user = current_customer
    @newaddress = Address.new
    @addresses = @user.addresses
  end

  def create
    @newaddress = Address.new(address_params)
    @newaddress.customer = current_customer
    if @newaddress.save
      redirect_to addresses_path
    else
      flash[:address_created_error] = "正常に保存されませんでした。"
      @user = current_customer
      @addresses = @user.addresses
      render :index
    end
  end

  def edit
    @user = current_customer
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

# 登録データのストロングパラメータ
  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
