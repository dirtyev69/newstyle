namespace 'Lib'

class Lib.ViewSwither
  constructor: (@$container) ->

    self = this

    console.log ('asdads')

    $item = @$container.find('@viewItem')


    if $.cookie('view') == 'small'
      self.$container.find('@viewSwitherLarge').removeClass('active')
      self.$container.find('@viewSwitherSmall').addClass('active')
      self.$container.find('@masonry').addClass('gallery__list-small')

    @$container.find('@viewSwitherSmall').off("click").on("click", ->
      $.cookie('view', 'small', { path: '/'} )

      self.$container.find('@viewSwitherLarge').removeClass('active')
      $(this).addClass('active')
      self.$container.find('@masonry').addClass('gallery__list-small').masonry('reloadItems').masonry('layout')
    )

    @$container.find('@viewSwitherLarge').off("click").on("click", ->
      $.cookie('view', 'large', { path: '/'} )

      self.$container.find('@viewSwitherSmall').removeClass('active')
      $(this).addClass('active')
      self.$container.find('@masonry').removeClass('gallery__list-small').masonry('reloadItems').masonry('layout')
    )

