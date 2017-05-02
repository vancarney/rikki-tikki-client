#### global
# > References the root environment APIHero is operating in
_global = module.exports ? window
# Includes Backbone & Underscore if the environment is NodeJS
_            = _global._ || unless typeof exports is 'null' then require 'lodash' else null
Backbone     = _global.Backbone || unless typeof exports is 'null' then require 'backbone' else null
Backbone.$   = _global.jQuery || unless typeof exports is 'null' then require 'jquery' else null
'{{wf_utils}}'
unless _global.APIHero
  #### global.APIHero
  # > Defines the `APIHero` namespace in the 'global' environment
  APIHero = _global.APIHero = (->
    $extend = {}
    _local = {}
    __defaults__ = 
      #### __COLLECTIONS__
      #> Placeholder for Schemas
      __COLLECTIONS__: {}
      __OPTIONS__:
        ALLOWED: ['APP_ID', 'REST_KEY', 'HOST', 'PORT', 'BASE_PATH', 'MAX_BATCH_SIZE', 'DEFAULT_FETCH_LIMIT_OVERRIDE', 'UNDEFINED_CLASSNAME']
        #### VERSION
        # > The current APIHero Version Number
        VERSION:'0.1.1-alpha'
        #### APP_ID 
        # > The Parse API Application Identifier
        APP_ID:"null"
        APP_ID_PARAM_NAME:'APP_ID'
        #### REST_KEY 
        # > The Parse API REST Access Key
        REST_KEY:"null"
        REST_KEY_PARAM_NAME:'REST_KEY'
        #### SESSION_TOKEN
        # > The User's Session Token if signed in
        SESSION_TOKEN:"null"
        SESSION_KEY: 'AUTHORIZATION'
        #### SESSION_TOKEN
        # > The User's CSRF Authentication Token for anti-forgery
        CSRF_TOKEN:"null"
        #### API_VERSION
        # The supported Parse API Version Number
        API_VERSION:'1'
        #### MAX_BATCH_SIZE
        # > The `APIHero.Batch `request object length 
        # Can be set to -1 to disable sub-batching
        # >   
        # **Note**: Changing this may cause `APIHero.Batch` requests to fail
        MAX_BATCH_SIZE:50
        #### DEFAULT_FETCH_LIMIT_OVERRIDE
        # > Stores maximum number of records to retrieve in a `fetch` operation.
        # >  
        # **Note**: Parse limits fetch requests to 100 records and provides no pagination. To circumvent this, we override the Fetch Limit to attempt to pull all records set this to a lower or higher amount to suit your needs
        # >
        # **See also**: REST API Queries
        DEFAULT_FETCH_LIMIT_OVERRIDE: 200000
        #### UNDEFINED_CLASSNAME
        # > Default ClassName to use for Models and Collections if none provided or detected
        UNDEFINED_CLASSNAME:'__UNDEFINED_CLASSNAME__'
        #### API_URI
        # > Base URI for the Parse API
        API_URI:"null"
        CORS:true
        PROTOCOL: 'HTTP'
        HOST: '0.0.0.0'
        PORT: 80
        BASE_PATH: '/api'
        CAPITALIZE_CLASSNAMES: false
        CRUD_METHODS:
          create: 'POST'
          read: 'GET'
          update: 'PUT'
          destroy:'DELETE'
        QUERY_PARAM: 'filter'
    _appLayer = (ns)->
      throw new ReferenceError "Required argument 'ns' was not defined" unless ns?
      throw new TypeError "Namespace required to be type 'String'. Type was '<#{type}>'" unless (type = typeof ns) is 'string'
      console.log '__defaults__:'
      console.log JSON.stringify __defaults__, null, 2
      $scope = global["#{ns}"] = new Namespace _.extend {}, $extend, __defaults__
      $scope.SchemaRoller = _sr
      $scope.wf = _global.wf
      '{{classes}}'
      return $scope
    # app = 
      # listCollection: (object)->
        # Object.keys @get '__COLLECTIONS__'
    createScope = (ns, config)->
      return global[ns] if global[ns]
      global[ns] = _appLayer ns
      if config?
        console.log 'config'
        _obj = {}
        _.assignIn _obj, __defaults__, config
        console.log _obj
        global[ns].set _obj
      global[ns]
      # APIHero.createCollection = (name, options={})->
        # new (APIHero.Collection.extend options, className:name)
      # setOptions: (opts={})->
        # @set _.extend __defaults__, opts
    app = 
      init: (config)->
        _.each config, (k,v)=> createScope k, v
        createScope: createScope
      extend: (schema)->
        $extend = schema 
  )()
  # __schema__ = `{
    # "extensible": true,
    # "elements": {
      # "__COLLECTIONS__": {
        # "type": "Object",
        # "required": true,
        # "extensible": true,
        # "elements": {
          # "type": "Schema",
          # "required": false,
          # "extensible": true,
        # }
      # },
      # "__OPTIONS__": {
        # "type": "Object",
        # "required": true,
        # "extensible": true,
        # "elements": {
          # "ALLOWED": {
            # "type": "Array",
            # "required": true,
            # "elements": {
              # "type": "String",
              # "required": false
            # }
          # },
          # "VERSION": {
            # "type": "String",
            # "required": false,
            # "restrict": "/\\\\bv?(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)(?:-[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?(?:\\\\+[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?\\\\b/ig"
          # },
          # "APP_ID": {
            # "type": "String",
            # "required": true,
            # "restrict": "/^[a-zA-Z0-9]{16,32}$/"
          # },
          # "APP_ID_PARAM_NAME": {
            # "type": "String",
            # "required": false
          # },
          # "REST_KEY": {
            # "type": "String",
            # "required": true,
            # "restrict": "/^[a-zA-Z0-9]{16,32}$/"
          # },
          # "REST_KEY_PARAM_NAME": {
            # "type": "String",
            # "required": false
          # },
          # "SESSION_TOKEN": {
            # "type": "String",
            # "required": false
          # },
          # "SESSION_KEY": {
            # "type": "String",
            # "required": true,
            # "restrict": "/^[a-zA-Z0-9]{16,32}$/"
          # },
          # "CSRF_TOKEN": {
            # "type": "String",
            # "required": false,
            # "restrict": "/^[a-zA-Z0-9]{16,32}$/"
          # },
          # "API_VERSION": {
            # "type": "String",
            # "required": true
          # },
          # "MAX_BATCH_SIZE": {
            # "type": "Number",
            # "required": false,
            # "default": 50
          # },
          # "DEFAULT_FETCH_LIMIT_OVERRIDE": {
            # "type": "Number",
            # "required": false,
            # "default": 50000
          # },
          # "UNDEFINED_CLASSNAME": {
            # "type": "String",
            # "required": false,
            # "default": "__UNDEFINED_CLASSNAME__"
          # },
          # "API_URI": {
            # "type": "String",
            # "required": false
          # },
          # "CORS": {
            # "type": "Boolean",
            # "required": false,
            # "default": false
          # },
          # "PROTOCOL": {
            # "type": "String",
            # "required": false,
            # "default": "http",
            # "restrict": "/^(HTTP)+S?$/i"
          # },
          # "HOST": {
            # "type": "String",
            # "required": false,
            # "default": "127.0.0.1",
            # "restrict": "^(?:[0-9]{1,3}\\\\.){3}[0-9]{1,3}$"
          # },
          # "PORT": {
            # "type": "Number",
            # "required": false,
            # "default": 3000
          # },
          # "BASE_PATH": {
            # "type": "String",
            # "required": false,
            # "default": "/api",
            # "restrict": "/^\\\\/+[a-zA-Z0-9_\\\\/\\\\.\\\\-]+$/"
          # },
          # "CAPITALIZE_CLASSNAMES": {
            # "type": "Boolean",
            # "required": false,
            # "default": true
          # },
          # "CRUD_METHODS": {
            # "type": "Object",
            # "required": true,
            # "extensible": false,
            # "default": {
              # "create": "POST",
              # "read": "GET",
              # "update": "PUT",
              # "destroy": "DELETE"
            # },
            # "elements": {
              # "create": {
                # "type": "String",
                # "required": false,
                # "restrict": "/^POST+$/"
              # },
              # "read": {
                # "type": "String",
                # "required": false,
                # "restrict": "/^GET+$/"
              # },
              # "update": {
                # "type": "String",
                # "required": false,
                # "restrict": "/^PUT+$/"
              # },
              # "destroy": {
                # "type": "String",
                # "required": false,
                # "restrict": "/^DELETE+$/"
              # }
            # }
          # },
          # "QUERY_PARAM": {
            # "type": "String",
            # "required": false,
            # "restrict": "/^[a-zA-Z0-9_$/"
          # }
        # }
      # }
    # }
  # }`
  
  __schema__ =
    extensible: true
    elements:
      __COLLECTIONS__:
        type: 'Object'
        required: true
        extensible: true
        elements:
          type: 'Object'
          required: true
      __OPTIONS__:
        type: 'Object'
        required: true
        extensible: true
        elements:
          ALLOWED:
            type: 'Array'
            required: true
            elements:
              type: 'String'
              required: false
          VERSION:
            type: 'String'
            required: false
            restrict: "/\\\\bv?(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)(?:-[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?(?:\\\\+[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?\\\\b/ig"
          APP_ID:
            type: 'String'
            required: true
            restrict: "/^[a-zA-Z0-9]{16,32}$/"
          APP_ID_PARAM_NAME:
            type: 'String'
            required: false
          REST_KEY:
            type: 'String'
            required: true
            restrict: '/^[a-zA-Z0-9]{16,32}$/'
          REST_KEY_PARAM_NAME:
            type: 'String'
            required: false
          SESSION_TOKEN:
            type: 'String'
            required: false
          SESSION_KEY:
            type: 'String'
            required: true
            restrict: '/^[a-zA-Z0-9]{16,32}$/'
          CSRF_TOKEN:
            type: 'String'
            required: false
            restrict: '/^[a-zA-Z0-9]{16,32}$/'
          API_VERSION:
            type: 'String'
            required: true
            #restrict: '/\\\\bv?(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)\\\\.(?:0|[1-9]\\\\d*)(?:-[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?(?:\\\\+[\\\\da-z\\\\-]+(?:\\\\.[\\\\da-z\\\\-]+)*)?\\\\b/ig'
          MAX_BATCH_SIZE:
            type: 'Number'
            required: false
            default: 50
          DEFAULT_FETCH_LIMIT_OVERRIDE:
            type: 'Number'
            required: false
            default: 50000
          UNDEFINED_CLASSNAME:
            type: 'String'
            required: false
            default: '__UNDEFINED_CLASSNAME__'
            restrict: '/^[a-zA-Z0-9_]+$/'
          API_URI:
            type: 'String'
            required: false
            default: '/api'
            restrict: '/^[a-zA-Z0-9_]+$/'
          CORS:
            type: 'Boolean'
            required: false
            default: false
          PROTOCOL:
            type: 'String'
            required: false
            default: 'http'
            restrict: '/^(HTTP)+S?$/i'
          HOST:
            type: 'String'
            required: false
            default: '127.0.0.1'
            restrict: '^(?:[0-9]{1,3}\\\\.){3}[0-9]{1,3}$'
          PORT:
            type: 'Number'
            required: false
            default: 3000
          BASE_PATH:
            type: 'String'
            required: false
            default: '/api'
            restrict: '/^\\\\/+[a-zA-Z0-9_\\\\/\\\\.\\\\-]+$/'
          CAPITALIZE_CLASSNAMES:
            type: 'Boolean'
            required: false
            default: true
          CRUD_METHODS:
            type: 'Object'
            required: true
            extensible: true
            # default:
              # create: 'POST'
              # read: 'GET'
              # update: 'PUT'
              # destroy: 'DELETE'
            elements:
              create:
                type: 'String'
                required: false
                restrict: '/^POST+$/'
              read:
                type: 'String'
                required: false
                restrict: '/^GET+$/'
              update:
                type: 'String'
                required: false
                restrict: '/^PUT+$/'
              destroy:
                type: 'String'
                required: false
                restrict: '/^DELETE+$/'
          QUERY_PARAM:
            type: 'String'
            required: false
            restrict: '/^[a-zA-Z0-9_$/'
  SchemaRoller =  require 'schemaroller' #_global.SchemaRoller || unless typeof exports is 'null' then require 'schemaroller' else null
  _sr = SchemaRoller()
  class Namespace extends _sr.Schema
    constructor: (config)->
      super __schema__
      @getOptions =  (name)=>
        @get "__OPTIONS__#{if name? then '.'+name else ''}"
      @setOptions =  (name, val)=>
        switch typeof name
          when 'string'
            @set "__OPTIONS__.#{name}", val
          when  'object'
            @set '__OPTIONS__', name
          else
            throw "setOptions: invalid arguments given"
      @listCollections = =>
        Object.keys @get '__COLLECTIONS__'
      # @collections = =>
        # @get '__COLLECTIONS__'
      @getCollection = (name)=>
        if (_c = @get '__COLLECTIONS__')?.hasOwnProperty name then _c[name] else null
      @createCollection = (schema)->
        new @Collection schema 
      @addCollection = (name, coll)=>
        unless name?
          throw new ReferenceError "Required argument 'name' was not defined"
        if (@getCollection name)?
          throw new ReferenceError "Collection '#{name}' already exists"
        # console.log @Collection
         # _s =  if coll instanceof @Collection then coll else @createCollection coll
        _colls = @get '__COLLECTIONS__'
        _colls.set name, _s || {}
        @[name] = _s   
      @removeCollection = (name)=>
        return unless (_c = @get '__COLLECTIONS__')?.hasOwnProperty name
        delete _c[name]
        @set '__COLLECTIONS__', _c
      if config?
        @set config   
