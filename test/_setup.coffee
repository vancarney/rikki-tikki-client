(chai           = require 'chai').should()
http            = require 'http'
Router          = require 'routes'
Adapter         = require 'rikki-tikki-express'
# RikkiTikki      = require '../index'
RikkiTikkiAPI   = require 'Rikki-Tikki'
port            = 3000
# describe 'Initialize Rikki-Tikki-Client Test Suite', ->
  # it 'should setup our testing environment', (done)=>
new RikkiTikkiAPI( {
  destructive: true
  config_path: './test/scripts/configs'
  schema_path: './test/scripts/schemas'
  adapter: (@adapter = RikkiTikkiAPI.createAdapter 'routes', router:new Router)
}).on 'open', (e)=>
  throw e if e?
  @server = http.createServer @adapter.requestHandler
  @server.listen port
  # done()