#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'hand:bust',  @playerBust,  @
    @get('playerHand').on 'hand:stand', @playerStand, @
    @get('dealerHand').on 'hand:bust',  @dealerBust,  @
    @get('dealerHand').on 'hand:stand', @dealerStand, @

  # Example of how you might start a new game
  newGame: (newDeck = false) ->
    if newDeck
      @set 'deck', deck = new Deck()
    @get('playerHand').newGame(deck) # newGame is not implemented
    @get('dealerHand').newGame(deck) # newGame is not implemented

  playerBust: ->
    @trigger 'win:dealer'

  playerStand: ->
    @get('dealerHand').playToWin()

  dealerBust: ->
    @trigger 'win:player'

  dealerStand: ->
    @findWinner()

  findWinner: ->
    if @get('playerHand').maxScore() > @get('dealerHand').maxScore()
      @trigger 'win:player'
    else if @get('playerHand').maxScore() < @get('dealerHand').maxScore()
      @trigger 'win:dealer'
    else
      @trigger 'push'

### ALTERNATE APPROACH

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'all', @playerEvents, @
    @get('dealerHand').on 'all', @dealerEvents, @

  playerEvents: (event, hand) ->
    switch event
      when 'hand:bust'  then @trigger 'win:dealer'
      when 'hand:stand' then @get('dealerHand').playToWin()

  dealerEvents: (event, hand) ->
    switch event
      when 'hand:bust'  then @trigger 'win:player'
      when 'hand:stand' then @findWinner()

  findWinner: ->
    if @get('playerHand').maxScore() > @get('dealerHand').maxScore()
      @trigger 'win:player'
    else if @get('playerHand').maxScore() < @get('dealerHand').maxScore()
      @trigger 'win:dealer'
    else
      @trigger 'push'

###