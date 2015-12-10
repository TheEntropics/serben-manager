$ ->
  loadStatus = ->
    updateGame = (div, url)->
      $.ajax
        url: url
        success: (data)->
          $(div).html(data)
        fail: (data)->
          $(div).html("<br>Error loading</br>")
          console.error(data)

    asyncStatuses = $('.async-status')
    for div in asyncStatuses
      updateGame(div, $(div).attr('data-game-status'))

  $(document).ready(loadStatus)
  $(document).on('page:load', loadStatus)