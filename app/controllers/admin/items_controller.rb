class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page]).per(8)
  end

# 商品新規登録
  def new
    @item = Item.new
  end

# 商品情報の新規登録
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      flash[:item_created_error] = "商品情報が正常に保存されませんでした。"
      render new_admin_item_path
    end
  end

# 商品詳細
  def show
    @item = Item.find(params[:id])
  end

# 商品編集
  def edit
    @item = Item.find(params[:id])
  end

# 商品編集の更新
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      flash[:item_updated_error] = "商品情報が正常に保存されませんでした。"
      redirect_to edit_admin_item_path(item)
    end
  end

# 登録データのストロングパラメータ
  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
