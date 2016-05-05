#= require jquery
#= require jquery_ujs
#= require jquery.role
#= require role
#= require fotorama
#= require bootstrap-sass

#= require nprogress/nprogress.js
#= require imagesloaded/imagesloaded.pkgd
#= require masonry/dist/masonry.pkgd

#= require fancybox/source/jquery.fancybox.pack
#= require fancybox/source/helpers/jquery.fancybox-thumbs
#= require jquery-cookie

#= require underscore/underscore.js
#= require js-routes
#= require underscore.string/underscore.string.js
#= require jquery-autosize
#= require_tree ./ext
#= require_tree ./lib
#= require_tree ./pages
#= require_tree ./templates

#= require_tree .
#= require_self


$(document).ready(() => {
  window.Style = new Style($(document))
});


class Style {
  constructor(container) {
    this.container = container;

    let self = this.container;

    new Lib.Gallery($(self));

    new Lib.Masonry($(self).find('@masonry'));

    new Lib.Pagi($(self).find('@pagination'));

    new Lib.SortByType($(self).find('@paginatable'))

    new Lib.ViewSwither($(self))

    new Lib.Up($(self).find("@up"))

    $(self).on("click", e => {
      self.$container.find('@searchForm').removeClass('active');
    });

    $('@searchForm').on("click", e => {
      e.stopPropagation();
    });

    $(self).find('@toggleSearch').off("click").on("click", (e) => {
      e.stopPropagation();
      $(self).find('@searchForm').toggleClass('active');
    });


    $('@imageGrid').imageGridNew({
      rowCount: 3,
      grid: 0,
      minRowHeight: 250,
      maxRowHeight: 450
    });


    $(self).find('@modal').on('hidden.bs.modal', (e) => {
      $(e.target).removeData('bs.modal')
      $(e.target).find('@modalContent').empty()
      $.fancybox.close()
    });

  }
}


