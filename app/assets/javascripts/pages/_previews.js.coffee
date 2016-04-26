namespace 'Pages'

class Pages.Previews
  constructor: (@$container) ->
    self = this


    @$container.find('@fancyboxThumb').fancybox
      loop: true
      prevEffect  : 'none'
      nextEffect  : 'none'
      padding: 0
      closeBtn: false
      helpers:
        overlay : null
        title:
          type : 'float'
        thumbs:
          width: 60
          height: 60

    @$container.find('@fancyboxThumb:first').click()



