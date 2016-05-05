namespace 'Lib'

class Lib.Masonry
  constructor: (@$container) ->

    self = this

    @$container.imagesLoaded ->
      self.$container.masonry
        transitionDuration: 0
        singleMode: true