class Admin::DeliveriesController < Admin::BaseController
  def index
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(params[:delivery])
    if @delivery.save

      DeliveryMail.send_mail(@delivery).deliver_now
      # flash[:notice] = "Successfully created gallery."
      # redirect_to request.referrer
      render :action => 'new'
    else
      render :action => 'new'
    end
  end

end
