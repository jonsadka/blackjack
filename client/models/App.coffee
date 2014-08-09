#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand', ->
      @get('dealerHand').dealerTurn()
    , @)

    @get('playerHand').on('endgame', ->
      console.log 'You Lost, Please refresh the page to play again'
    , @)

    @get('dealerHand').on('endgame', ->
      console.log 'You Won, Please refresh the page to play again'
    , @)

    # @get('playerHand').on('hit', ->
    #   playerhand = @get('playerHand')
    #   playerscore = playerhand.scores()[0]
    #   console.log(playerhand)

    #   dealerhand = @get('dealerHand')
    #   dealerscore = dealerhand.scores()[0]

    #   if playerscore > 21 or dealerscore > 21
    #     console.log "greater than 21"
    #     # @set 'deck', deck = new Deck()
    #     deck.initialize()
    #     newhand = deck.dealPlayer()
    #     @set('playerHand', newhand)
    #     # playerhand.reset(deck.dealPlayer())
    #     console.log playerhand
    #     # dealerhand.reset(deck.dealDealer())
    #     # @set 'playerHand', deck.dealPlayer()
    #     # @set 'dealerHand', deck.dealDealer()
    # , @)

  # if dealerhand <=17, hit dealer hand until 17 or greater

