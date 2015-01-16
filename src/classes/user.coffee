#### $scope.User
# > Implements the Parse API `User` Object Type
class $scope.User extends $scope.Object
  #### defaults
  # > default user values for login
  defaults:
    username:null
    password:null
    email:null
  #### __action
  # > holds the action type
  __action:'operate'
  #### urlMap
  # > Map of routes addressed `__action` type
  urlMap:
    create:"#{$scope.API_URI}/users"
    login:"#{$scope.API_URI}/login"
    passwordReset:"#{$scope.API_URI}/requestPasswordReset"
    operate:"#{$scope.API_URI}/users"
  #### url()
  # > Overrides `$scope.Object.url`
  url:->
    @urlMap[@__action] + ( if @__action == 'operate' and !@isNew() then "/#{@get 'objectId'}" else '')
  #### signUp(attrs,[options])
  # > Provides Parse API User.signUp feature
  signUp:(attrs, options)->
    # calls save to invoke `__action` type 'create'
    @save attrs || null, options
  #### logIn()
  # > Provides Parse API User.logIn feature
  logIn:(username, password, options)->
    # sets `__action` type to 'login'
    @__action = 'login'
    # sets `urlMap` address 'login' to parameterized query string
    @urlMap['login'] = encodeURI @urlMap['login'].replace /\/login+.*/, "/login?username=#{username}&password=#{password}"
    # initializes `opts` with success callback
    (opts = {}).success = (m,r,o)=>
      # sets `$scope.SESSION_TOKEN`
      $scope.SESSION_TOKEN = @get 'sessionToken'
      # deletes `sessionToken` from attributes
      delete @attributes.sessionToken
      # invokes user defined success callback if exists
      options.success m,r,o if options.success
    # calls `fetch`
    @fetch _.extend _.clone(options), opts
  #### logout()
  # > Provides non-supported logout feature as a convenience
  logOut:->
    # resets `$scope.SESSION_TOKEN`
    $scope.SESSION_TOKEN = undefined
    # resets `urlMap` address 'login' to default
    @urlMap['login'] = @urlMap['login'].replace /\/login+.*/, '/login'
    # resets id
    @id = null
    # resets `attributes` to `defaults`
    @set @defaults
  #### resetPassword([options])
  # > Provides Parse API resetPassword feature
  resetPassword:(options)->
    # returns false if email is empty
    return false if (email = @get 'email') == null
    # sets `__action` to type 'passwordReset'
    @__action = 'passwordReset'
    # calls `save` on __super__
    User.__super__.save.call @, {email:email}, options
  #### save(attributes, [options])
  # > Overrides `$scope.Object.save`
  save:(attrs, opts)->
    # sets `__action` type to `create` or `operate`
    @__action = (if @.isNew() then 'create' else 'operate')
    # calls `save` on __super__
    User.__super__.save.call @, attrs, opts
  #### destroy([options])
  # > Overrides `$scope.Object.destroy`
  destroy:(options)->
    # sets `__action` to 'operate'
    @__action = 'operate'
    # initializes `opts` with success callback
    (opts = {}).success = (m,r,o)=>
      # calls `logout` on success
      @logOut()
      # invokes `options.success` user callback if exists
      options.success m,r,o if options.success
    # calls `destroy` on __super__
    User.__super__.destroy.call @, _.extend _.clone(options), opts