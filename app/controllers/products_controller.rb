class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
  end

  def create_payment
    @product = Product.find(params[:product_id])
    amount = params[:amount]
    merchant_id = params[:product_id]

    response = create_rapyd_payment(amount, merchant_id)

    if response['status']['status'] == 'SUCCESS'
      puts response
      redirect_to response['data']['redirect_url'], allow_other_host: true
    else
      puts response['status']['message']
      flash[:alert] = 'Payment Failed'
      redirect_to product_path(@product)
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def create_rapyd_payment(amount, merchant_id)
    payment_data = {
      "amount": amount,
      "complete_payment_url": "http://example.com/complete",
      "country": "US",
      "currency": "USD",
      "error_payment_url": "http://example.com/error",
      "language": "en",
      "merchant_reference_id": "product_#{merchant_id}"
    }

    RapydSignature.make_rapyd_request('post', '/v1/checkout', payment_data)
  end
end
