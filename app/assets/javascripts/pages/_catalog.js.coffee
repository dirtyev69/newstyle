namespace 'Pages'

class Pages.Catalog
  constructor: (@$container) ->
    self = this

    $galleryItem = @$container.find('@galleryItem')
