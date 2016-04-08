namespace 'Lib'

class Lib.ImageGrid
  constructor: (@$container) ->

    self = this


    len = @$container.find('@imageGrid img').length
    Tstep = 2

    @$container.imagesLoaded ->
      docWidth = $(window).width()
      if $( window ).width() < 768
        step = 1
      else
        step = Tstep
      self._setup_grid(step, len, docWidth)
      $( window ).resize ->
        docWidth = $(window).width()
        console.log docWidth
        if $( window ).width() < 768
          step = 1
        else
          step = Tstep
        self._setup_grid(step, len, docWidth)


  _setup_grid: (step, len, docWidth)  ->
    i = 0
    while i < len
      j = 0
      s = 0
      k = 0
      while j < step
        if i + j <= len - 1
          $element = $($(document).find('@imageGrid img')[i + j])
          elementH = $element.height()
          elementW = $element.width()
          s += elementW / elementH
        j += 1
      while k < step
        if i + k <= len - 1
          $element = $($(document).find('@imageGrid img')[i + k])
          elementH = $element.height()
          elementW = $element.width()
          height = docWidth / s
          $element.css({height: height + 'px'})
          width = (elementW / elementH) * height
          $element.css({width: width + 'px'})
        k +=1
      i += step





