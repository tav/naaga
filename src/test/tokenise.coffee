# Public Domain (-) 2010-2011 The NaagaJS Authors.
# See the NaagaJS UNLICENSE file for details.

vows = require 'vows'
assert = require 'assert'

ucd = require '../ucd'
parser = require '../parser'
tokenise = parser.tokenise

getLastToken = (text) ->
    tokens = tokenise(text)
    lastToken = tokens[tokens.length - 1]
    [lastToken[0], lastToken[3]]

vows.describe('Naaga Tokenisation').addBatch

    'When tokenising "12345"':

        topic: ->
            getLastToken '12345'

        'we get a value which':

            'is interpreted as being unicode category Nd (decimal numbers)': (topic) ->
                assert.equal(topic[0], ucd.Nd)

            'and matches the entire string': (topic) ->
                assert.equal(topic[1], '12345')

    'But when tokenising "123 foo 456"':

        topic: ->
            getLastToken "123 foo 456"

        'we get a value which':

            'only matches the last 3 characters': (topic) ->
                assert.equal(topic[1], '456')

            'but is also recognised as unicode category Nd': (topic) ->
                assert.equal(topic[0], ucd.Nd)

.export module
