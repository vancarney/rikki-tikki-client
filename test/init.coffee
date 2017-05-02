fs              = require 'fs'
{should, expect} = require 'chai'
_               = (require 'underscore')._
Backbone        = require 'backbone'
Backbone.$      = require 'jQuery'
{APIHero}       = require '../lib/rikki-tikki-client'
jsonData        = require './data.json'
server          = true

describe.only "APIHero initializtion Test Suite", ->
  it 'should initialize', =>
    expect( @_apiHero = APIHero.init()).to.be.a 'object'
    @_apiHero.createScope.should.be.a 'function'
  it "should create namespace", =>
    expect(@_api = @_apiHero.createScope 'api').to.be.a 'object'
    @_api.createCollection.should.be.a 'function'
  it 'should have default options', =>
    console.log @_api.getOptions('PROTOCOL')
    
