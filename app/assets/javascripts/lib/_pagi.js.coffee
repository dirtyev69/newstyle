namespace 'Lib'

class Lib.Pagi
  constructor: (@$container) ->

    if @$container.length > 0
      self = this


    @$container.parents(':first').off('click', '@more').on('click', '@more'
      ->
        return false if self.$container.data('loading')

        self._load(this.href)
        return false
    )

  _load: (url) ->
    self = this

    self.$container.html(JST['templates/_spinner']()).data('loading', true)

    $.ajax(
      url: url
      type: 'GET'
      dataType: 'json'
    ).done(
      (json) ->
        self.$container.data('loading', false)

        window.history.pushState('string', document.title, url)

        if json?
          $html = $(json.data).css({ opacity: 0 })
          $list = $(document).find('@masonry')

          $list.append($html).imagesLoaded(
            ->
              self.$container.html(json.pagination)
              $html.animate({ opacity: 1 })

              # $list.append($html)
              $list.masonry('appended', $html, true)
          )
      )
