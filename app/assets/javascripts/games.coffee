$ ->
  updateGame = (div, url)->
    $.ajax
      url: url
      success: (data)->
        $(div).html(data)
        console.log(div, data)

  asyncStatuses = $('.async-status')
  for div in asyncStatuses
    updateGame(div, $(div).attr('data-game-status'))
