# {should, expect} = require 'chai'
# {APIHero}        = require '../lib/rikki-tikki-client'
# # SchemaRoller    = require 'schemaroller'
# # console.log "SchemaRoller init: #{SchemaRoller}"
# 
# describe.only 'APIHero.Schema Test Suite', ->
  # before =>
    # @myNS = APIHero.createScope 'myNS'
#     
  # it 'should have new scope', =>
    # @myNS.should.be.a 'object'
#     
  # it 'should create a new schema in the namespace', =>
    # @schema = new @myNS.Schema
      # extensible: false
      # elements:
        # name:
          # type: "String"
          # required: true
        # description:
          # type: "String"
          # required: true
        # price:
          # type: "Number"
          # required: true
        # foo:
          # type:"Date"
          # default:"Date.now"
    # @schema.set 
      # name: "Test"
      # price: 3.50
      # description: "Foo diddly who diddly"
          # # illegal:true
          # # validators:[ ((value)-> typeof value == 'string'), 'must be string']
    # @schema.should.be.a 'object'
  # it 'Schema should create paths', =>
    # @schema.get('name').should.equal 'Test'
  # # it 'Schema should define an instance from a passed native Object', =>
    # # @schema.paths.name.instance.should.be.a 'function'
  # # it 'Schema should define an instance from a param type', =>
    # # @schema.paths.foo.instance.should.be.a 'function'
  # # it 'Schema should allow validators', =>
    # # @schema.paths.foo.validators.should.be.a 'Array'
    # # @schema.paths.foo.validators[0][0].should.be.a 'function'
  # # it 'Schema should filter out invalid params', =>
    # # @schema.paths.foo.should.not.have.property 'illegal'