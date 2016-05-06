namespace 'Lib'

class Lib.SortByType
  constructor: (@$container) ->

    if @$container.length > 0
      self = this
      @loading = false

      # this._setup_sort_handler()

      @$masonry = $(document).find('@masonry')

      @$sortLink = $(document).find('@sortLink')

      console.log(@$sortLink)

      @$container.css({ opacity: 0 })

      self.$container.imagesLoaded ->
        self.$container.animate({ opacity: 1 })

      @$sortLink.off("click").on("click", (e) ->
        e.preventDefault()

        self.$sortLink.closest("li").removeClass('active')
        $(e.target).closest("li").addClass('active')

        self.$container.html(JST['templates/_spinner']()).data('loading', true)

        url = e.target.href

        $.ajax(
          url: url
          type: 'GET'
          dataType: 'json'
        ).done(
          (json) ->

            # console.log(json.data)

            # console.log(json.pagination)

            self.loading = false
            url = url.replace(/\/sort_by_type/, "")

            # if $(document).find('@more').length > 0
            #   $(document).find('@more')[0].href = url

            self.$container.data('loading', false)
            window.history.pushState('string', document.title, url)

            if json?
              $html = $(json.data).css({ opacity: 0 })
              $list = $(document).find('@masonry')

              $list.empty()

              $list.append($html).imagesLoaded(
                ->

                  $pagination = $(document).find('@pagination')
                  $pagination.html(json.pagination)

                  $html.animate({ opacity: 1 })

                  @$masonry = $(document).find('@masonry')
                  $list.masonry('appended', $html, true)
                  $list.masonry('reloadItems')
                  $list.masonry('layout')

              )
          )
      )
