assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it "should give the last card from the deck", ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49
      hand.playable && (assert.strictEqual deck.last(), hand.hit())
      hand.playable && (assert.strictEqual deck.length, 48)

  describe 'stand', ->
    it "should not do shit", ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.stand()
      assert.strictEqual deck.length, 50
      hand.playable && (assert.strictEqual deck.last(), hand.stand())
      hand.playable && (assert.strictEqual deck.length, 50)
