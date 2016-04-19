class Api::V1::ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    respond_with(Painting.all)
  end

end