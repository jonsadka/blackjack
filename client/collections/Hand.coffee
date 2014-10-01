class window.Hand extends Backbone.Collection

  model: Card

  playable: true

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    return if !@playable
    newCard = @add(@deck.pop())
    if @busted()
      @playable = false
      @trigger 'hand:bust', @
    newCard

  stand: ->
    return if !@playable
    @playable = false
    @trigger 'hand:stand', @

  playToWin: ->
    return if !@playable
    @first().flip()
    while @scores()[0] < 17
      @hit()
    if !@busted()
      @stand()

  busted: ->
    @maxScore() > 21

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  maxScore: ->
    scores = @scores()
    if scores.length > 1
      if scores[1] <= 21 then scores[1] else scores[0]
    else
      scores[0]
