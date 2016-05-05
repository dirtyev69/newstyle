class CatalogController < ApplicationController

  helper_method :paintings_collection, :search, :resource_gallery, :resource_painting

  def index
    @galleries = Gallery.show_on_main

    if request.xhr?
      render :json => {
        :data => render_to_string(:partial => 'catalog/shared/tiles', :locals => { :articles => paintings_collection(resource_gallery) }),
        :pagination => view_context.render_pagination(paintings_collection(resource_gallery))}
      return
    end
  end


  def sort_by_type
    @gallery = Gallery.show_on_main.first
    # render :layout => false

    if params[:type].present?
      @paintings_collection ||= @gallery.paintings.where(:item_type => params[:type]).ordered.newest_first.page(params[:page])
    else
      @paintings_collection ||= @gallery.paintings.ordered.newest_first.page(params[:page])
    end

    if request.xhr?
      render :json => {
        :data => render_to_string(:partial => 'catalog/shared/tiles', :locals => { :articles => @paintings_collection }),
        :pagination => view_context.render_pagination(@paintings_collection)}
      return
    end

  end


  def get_previews
    render :layout => false
    # if request.xhr?
    #   render :json => {
    #     :data => render_to_string(:partial => 'catalog/shared/previews', :locals => { :item => Painting.find(params[:painting_id]) })
    #     }
    #   return
    # end
  end

protected

  def resource_painting
    @painting = Painting.find(params[:painting_id])
  end

  def search
    params[:type] ? params[:type] : nil
  end

  def resource_gallery
    @gallery = Gallery.find(params[:id])
  end

  def paintings_collection(gallery)
    if params[:type].present?
      @paintings_collection ||= gallery.paintings.where(:item_type => params[:type]).ordered.newest_first.page(params[:page])
    elsif params[:all].present?
      @paintings_collection ||= gallery.paintings.ordered.newest_first
    elsif params[:query].present?
      @paintings_collection ||= gallery.paintings.text_search(params[:query]).ordered.newest_first.page(params[:page])
    else
      @paintings_collection ||= gallery.paintings.ordered.newest_first.page(params[:page])
    end
  end
end
