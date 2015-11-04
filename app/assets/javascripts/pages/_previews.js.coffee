namespace 'Pages'

class Pages.Previews
  constructor: (@$container) ->
    self = this

    @$container.find("@lightSlider").lightSlider
      gallery: true
      item: 1
      loop: true
      slideMargin: 0
      thumbItem: 9
      adaptiveHeight: true
      enableDrag: false
      keyPress: true
      responsive: [
        {
          breakpoint: 480
          settings:
            gallery: true
            thumbItem: 6
        }
      ]


    $slider = @$container.find("@lightSlider").lightSlider
    $slider.destroy()
