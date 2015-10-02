class Admin::PreviewsController < Admin::BaseController
  def destroy
    resource_preview.destroy
    redirect_to request.referrer
  end

protected
  def resource_preview
    @resource_painting ||= Painting.find(params[:painting_id])
    @resource_preview  ||= @resource_painting.previews.find(params[:id])
  end
end