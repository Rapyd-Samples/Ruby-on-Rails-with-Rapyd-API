class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
  end

  def create_payment
    checkout_page = {
      "amount": params[:payment][:amount],
      "complete_payment_url": "http://example.com/complete",
      "country": "US",
      "currency": "USD",
      "customer": "cus_9761efaa881b6edeab25e9fbfec1ddf5",
      "error_payment_url": "http://example.com/error",
      "merchant_reference_id": "0912-2021",
      "language": "en",
    }

    response = make_raypd_request('post', '/v1/checkout', checkout_page)

    if response['status'] == 'SUCCESS'
      redirect_to response['data']['redirect_url']
    else
      redirect_to product_path(@product), alert: 'Payment request failed'
    end

  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

end
