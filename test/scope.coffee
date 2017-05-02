{should,expect}         = require 'chai'
APIHero      = require('../lib/rikki-tikki-client').APIHero
# _sr = (require 'schemaroller')()
# console.log _sr
_schema = {
  "extensible": true,
  "elements": {
    "__COLLECTIONS__": {
      "type": "Object",
      "required": true,
      "elements": {
        "type": "Schema",
        "required": false
      }
    },
    "__OPTIONS__": {
      "type": "Object",
      "required": true,
      "elements": {
        "ALLOWED": {
          "type": "Array",
          "required": true,
          "elements": {
            "type": "String",
            "required": false
          }
        },
        "VERSION": {
          "type": "String",
          "required": false,
          "restrict": "/\\\\bv?(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)(?:-[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?(?:\\\\+[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?\\\\b/ig"
        },
        "APP_ID": {
          "type": "String",
          "required": true,
          "restrict": "/^[a-zA-Z0-9]{16,32}$/"
        },
        "APP_ID_PARAM_NAME": {
          "type": "String",
          "required": false
        },
        "REST_KEY": {
          "type": "String",
          "required": true,
          "restrict": "/^[a-zA-Z0-9]{16,32}$/"
        },
        "REST_KEY_PARAM_NAME": {
          "type": "String",
          "required": false
        },
        "SESSION_TOKEN": {
          "type": "String",
          "required": false
        },
        "SESSION_KEY": {
          "type": "String",
          "required": true,
          "restrict": "/^[a-zA-Z0-9]{16,32}$/"
        },
        "CSRF_TOKEN": {
          "type": "String",
          "required": false,
          "restrict": "/^[a-zA-Z0-9]{16,32}$/"
        },
        "API_VERSION": {
          "type": "String",
          "required": true
        },
        "MAX_BATCH_SIZE": {
          "type": "Number",
          "required": false,
          "default": 50
        },
        "DEFAULT_FETCH_LIMIT_OVERRIDE": {
          "type": "Number",
          "required": false,
          "default": 50000
        },
        "UNDEFINED_CLASSNAME": {
          "type": "String",
          "required": false,
          "default": "__UNDEFINED_CLASSNAME__"
        },
        "API_URI": {
          "type": "String",
          "required": false
        },
        "CORS": {
          "type": "Boolean",
          "required": false,
          "default": false
        },
        "PROTOCOL": {
          "type": "String",
          "required": false,
          "default": "http",
          "restrict": "/^(HTTP)+S?$/i"
        },
        "HOST": {
          "type": "String",
          "required": false,
          "default": "127.0.0.1",
          "restrict": "^(?:[0-9]{1,3}\\\\.){3}[0-9]{1,3}$"
        },
        "PORT": {
          "type": "Number",
          "required": false,
          "default": 3000
        },
        "BASE_PATH": {
          "type": "String",
          "required": false,
          "default": "/api",
          "restrict": "/^\\\\/+[a-zA-Z0-9_\\\\/\\\\.\\\\-]+$/"
        },
        "CAPITALIZE_CLASSNAMES": {
          "type": "Boolean",
          "required": false,
          "default": true
        },
        "CRUD_METHODS": {
          "type": "Object",
          "required": true,
          "extensible": false,
          "default": {
            "create": "POST",
            "read": "GET",
            "update": "PUT",
            "destroy": "DELETE"
          },
          "elements": {
            "create": {
              "type": "String",
              "required": false,
              "restrict": "/^POST+$/"
            },
            "read": {
              "type": "String",
              "required": false,
              "restrict": "/^GET+$/"
            },
            "update": {
              "type": "String",
              "required": false,
              "restrict": "/^PUT+$/"
            },
            "destroy": {
              "type": "String",
              "required": false,
              "restrict": "/^DELETE+$/"
            }
          }
        },
        "QUERY_PARAM": {
          "type": "String",
          "required": false,
          "restrict": "/^[a-zA-Z0-9_$/"
        }
      }
    }
  }
}
class FooClass 
  constructor:->
  exec:->
    return true

describe 'APIHero.$scope Test Suite', ->
  it 'should create a scope', ->
    _data = 
      # __OPTIONS__:{}
      __COLLECTIONS__: 
        foo: 
          name: 'foo'
          properties:
            name:
              type: 'String'
            data:
              type: 'String'
          
    console.log 'APIHero.init'
    _api = APIHero.init()
    console.log '-----------\ncreate scope'
    @scope = _api.createScope 'test', _data
    # console.log @scope.set _data
    # # @scope.collections.should.be.a 'function'
    # console.log 'scope created\n-----------------'
    console.log @scope.collections()
    # @scope.collections().foo.should.be.a 'object'
    # @scope.collections().foo.get('bar').should.equal 'baz'
    # process.exit 0
    
  # it 'should provide an extend method', ->
    # @scope.extend.should.be.a 'function'
  # it 'should extend the $scope',->
    # # APIHero.extend foobar: FooClass
    # (@scope = APIHero.createScope 'test2', foo: bar: 'baz').schema.foo.should.be.a 'object'
    # @scope.foobar.should.be.a 'function' 
