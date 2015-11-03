namespace 'Pages'

class Pages.Previews
  constructor: (@$container) ->
    self = this

    console.log 'init'

    @$container.find(".lightSlider").lightSlider
      gallery: true
      item: 1
      loop: true
      slideMargin: 0
      thumbItem: 6
      adaptiveHeight: true
