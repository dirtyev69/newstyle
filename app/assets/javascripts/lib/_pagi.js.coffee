namespace 'Lib'

class Lib.Pagi
  constructor: (@$container) ->



    if @$container.length > 0
      self = this
      @loading = false

      this._setup_scroll_handler()

      @$preloader = $(document).find('@preloader')

      @$container.css({ opacity: 0 })

      self.$container.imagesLoaded ->
        self.$container.animate({ opacity: 1 })
        self.$preloader.animate({ opacity: 0 }).remove()
    # @$container.parents(':first').off('click', '@more').on('click', '@more'
    #   ->
    #     return false if self.$container.data('loading')

    #     self._load(this.href)
    #     return false
    # )


  _setup_scroll_handler: ->
    self = this

    $(window).scroll ->

      unless self.loading
        wintop = $(window).scrollTop()
        docheight = $(document).height()
        winheight = $(window).height()
        scrolltrigger = 0.90

        if (wintop / (docheight - winheight)) > scrolltrigger


          if self.$container.find('@more').length > 0
            $(document).find('@catalogItem').animate({ opacity: 0 })
            self._load(self.$container.find('@more')[0].href)

            $(document).find('@catalogItem').animate({ opacity: 1 })
          else
            return false


  _load: (url) ->
    self = this

    self.$container.html(JST['templates/_spinner']()).data('loading', true)

    $.ajax(
      url: url
      type: 'GET'
      dataType: 'json'
    ).done(
      (json) ->

        self.loading = false

        self.$container.data('loading', false)

        window.history.pushState('string', document.title, url)

        if json?
          $html = $(json.data).css({ opacity: 0 })
          $list = $(document).find('@masonry')

          $list.append($html).imagesLoaded(
            ->
              self.$container.html(json.pagination)
              $html.animate({ opacity: 1 })

              $preloader = $(document).find('@preloader')

              $list.masonry('appended', $html, true)
              $preloader.animate({ opacity: 0 })

          )
      )




