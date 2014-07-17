#### global
# > References the root environment RikkiTikki is operating in
global = exports ? window
# Includes Backbone & Underscore if the environment is NodeJS
_         = (unless typeof exports is 'undefined' then require 'underscore' else global)._
Backbone  = (unless typeof exports is 'undefined' then require 'backbone' else global).Backbone
if !global.RikkiTikki
  #### global.RikkiTikki
  # > Defines the `RikkiTikki` namespace in the 'global' environment
  RikkiTikki = global.RikkiTikki =
    ALLOWED: ['APP_ID', 'REST_KEY', 'HOST', 'PORT', 'BASE_PATH', 'MAX_BATCH_SIZE', 'DEFAULT_FETCH_LIMIT_OVERRIDE', 'UNDEFINED_CLASSNAME']
    #### VERSION
    # > The current RikkiTikki Version Number
    VERSION:'0.1.1-alpha'
    #### APP_ID 
    # > The Parse API Application Identifier
    APP_ID:undefined
    APP_ID_PARAM_NAME:'APP_ID'
    #### REST_KEY 
    # > The Parse API REST Access Key
    REST_KEY:undefined
    REST_KEY_PARAM_NAME:'REST_KEY'
    #### SESSION_TOKEN
    # > The `RikkiTikki.User` Session Token if signed in
    SESSION_TOKEN:undefined
    #### API_VERSION
    # The supported Parse API Version Number
    API_VERSION:'1'
    #### MAX_BATCH_SIZE
    # > The `RikkiTikki.Batch `request object length 
    # Can be set to -1 to disable sub-batching
    # >   
    # **Note**: Changing this may cause `RikkiTikki.Batch` requests to fail
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
    API_URI:null
    CORS:true
    PROTOCOL: 'HTTP'
    HOST:'0.0.0.0'
    PORT: 80
    BASE_PATH:'/api'
    #### CRUD_METHODS
    # > Mappings from CRUD to REST
    CRUD_METHODS:
      create: 'POST'
      read:   'GET'
      update: 'PUT'
      destroy:'DELETE'
    #### __SCHEMAS__
    #> Placeholder for Schemas
    __SCHEMAS__:{}
  RikkiTikki.createNameSpace = (ns)->
    (if typeof window != 'undefined' then window else global)[ns] = _.extend {}, @
  RikkiTikki.getSchema = (name)->
    if (s = @__SCHEMAS__[name])? then s else null
  RikkiTikki.createSchema = (name, options={})->
    if (s = @getSchema name)? then _.extend s, options else RikkiTikki.__SCHEMAS__[name] = new RikkiTikki.Schema options
  # RikkiTikki.createCollection = (name, options={})->
    # new (RikkiTikki.Collection.extend options, className:name)
  RikkiTikki.initialize = (opts={}, callback)->
    _.each opts, (value, key) =>
      key = key.toUpperCase()
      if 0 <= @ALLOWED.indexOf key
        @[key] = value
      else
        throw "option: '#{key}' was not settable"
    @API_URL = @getAPIUrl()
    (@schemaLoader = new @SchemaLoader)
    .fetch 
      success:  => callback? null, 'ready'
      error:    => callback? 'failed', null