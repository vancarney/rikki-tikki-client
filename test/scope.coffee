(chai           = require 'chai').should()
RikkiTikki      = require('../lib/rikki-tikki-client').RikkiTikki

class FooClass 
  constructor:->
  exec:->
    return true

describe 'RikkiTikki.$scope Test Suite', ->
  it 'should create a scope', ->
    (@scope = RikkiTikki.createScope 'test', foo: bar: 'baz').schema.foo.should.be.a 'object'
  it 'should provide an extend method', ->
    @scope.extend.should.be.a 'function'
  it 'should extend the $scope',->
    RikkiTikki.extend foobar: FooClass
    (@scope = RikkiTikki.createScope 'test2', foo: bar: 'baz').schema.foo.should.be.a 'object'
    @scope.foobar.should.be.a 'function' 
    
  
