namespace 'Lib'

class Lib.Pagi
  constructor: (@$container) ->



    if @$container.length > 0
      self = this
      @loading = false

      this._setup_scroll_handler()

      @$container.css({ opacity: 0 })

      self.$container.imagesLoaded ->
        self.$container.animate({ opacity: 1 }, 300)
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
            # $(document).find('@catalogItem').animate({ opacity: 0 })
            self._load(self.$container.find('@more')[0].href)

            # $(document).find('@catalogItem').animate({ opacity: 1 })
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
          $html = $(json.data)
          $html.css('transform', 'translateY(' + 1000 + '%)')
          # TweenLite.to($html, 0,{ top: 1000 })

          $list = $(document).find('@masonry')

          $list.append($html).imagesLoaded(
            ->
              self.$container.html(json.pagination)
              # $html.animate({ transform: 'translateY(0)' })

              # TweenLite.to($('.catalog_item'), 0, {
              #   css: { display: 'none'}
              # })

              # TweenLite.to($('.catalog_item'), 1,{ y: 0 })
              # $('.catalog_item')animate.css('transform', 'translateY('+ 0 + '%)')

              # $('.catalog_item').css('transform', 'translateY(' + 0 + '%)')

              $html.addClass('animate')

              # TweenLite.to($('.catalog_item'), 0, { y: 0 })

              # $('.catalog_item').animate({ transform: 'translateY(0)' })

              $list.masonry('appended', $html, true)

          )
      )




