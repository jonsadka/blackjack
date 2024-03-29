class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'all', @updateGameStatus, @
    @render()

    @model.on('change:endGame', ->
      @render()
    , @)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  updateGameStatus: (event) ->
    switch event
      when 'win:player' then alert 'Player Wins!'
      when 'win:dealer' then alert 'Dealer Wins!'
      when 'push'       then alert 'Push'
