class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    # console.log(@scores())
    # if (@scores() > 21)
      # @trigger 'endgame'

  stand: ->
    @trigger 'stand'

  dealerTurn: ->
    card = @models[0]
    if card.get('revealed') is false then card.flip() else @hit()
    if @scores() < 17
      @dealerTurn()

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
    # result = if hasAce then [score, score + 10] else [score]
    card = @models[0]
    firstCardValue = card.get 'value'

    if firstCardValue is 1 and card.get("revealed") is true
      score = score + 10  if score + 10 < 21
    else if (firstCardValue is 1) and (card.get("revealed") is false)
      console.log "sdf"
    else score = score + 10  if hasAce and score + 10 < 21


    # if (firstCardValue === 1 && card.get('revealed')===true ){
    #   if (score + 10 < 21){
    #     score = score + 10
    #   }
    # } else if (firstCardValue === 1 && card.get('revealed') === false ){
    # } else if (hasAce && score + 10 < 21){
    #   score = score + 10
    # }

    # score = if (firstCardValue === 1 && card.get('revealed')===true ){
    #   if (score + 10 < 21){
    #     return score + 10
    #   } else {
    #     return score
    #   }
    # } else if (firstCardValue === 1 && card.get('revealed') === false ){
    #   return score
    # } else {
    #   if (hasAce and score + 10 < 21){
    #     return score + 10
    #   } else {
    #     return score
    #   }
    # }





    if (score > 21)
      @trigger 'endgame'
    score
