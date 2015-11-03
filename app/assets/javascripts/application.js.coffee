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

#= require underscore/underscore.js
#= require js-routes
#= require underscore.string/underscore.string.js
#= require lightslider
#= require jquery-autosize
#= require_tree ./ext
#= require_tree ./lib
#= require_tree ./pages
#= require_tree ./templates

$(document).ready ->
  window.Style = new Style($(document))

class Style
  constructor: (@$container) ->
    self = this

    # new Lib.Up(@$container.find("@up"))
    new Lib.Gallery(@$container)
    new Lib.Fancybox(@$container)
    new Lib.Masonry(@$container.find('@masonry'))

    new Lib.Pagi(@$container.find('@pagination'))


    autosize(@$container.find('@autosize'))

    @$container.find('@modal').on 'hidden.bs.modal', ->
      $(this).removeData('bs.modal')
      $(this).find('@modalContent').empty()

