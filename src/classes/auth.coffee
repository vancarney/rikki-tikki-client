#### RikkiTikki.Auth
# > Authentication Provider Interface
class $scope.Auth extends $scope.Object
  constructor:(token)->
    # _.extend @, Backbone.Events
    user  = new $scope.User
    login = null
    token ?= null
    # virtualizes user authentidation test helper method
    @isAuthenticated = => token?
    # virtualizes user login helper method
    @login = (username, password, options)=>
      success = options.success || null
      _.extend options, {
        success:(m,r,o)=>
          $scope.SESSION_TOKEN  = r.session_id
          $scope.CSRF_TOKEN     = r.csrf_token
          console.log r
          success?.apply @, arguments
      }
      (login ?= new $scope.Login).login username, password, options
    # virtualizes user logout helper method
    @logout = (options)=>
      (login ?= new $scope.Login token:token).logout arguments
    # virtualizes user session restoration helper method
    @restore = (token, options)=>
      (login ?= new $scope.Login token:token).restore token, options
    # virtualizes user settings getter method
    @getUser = => user.attributes
    # virtualizes user settings setter method
    @setUser = (attributes, options)=> user.set attributes, options
    # virtualizes user user settings update helper method
    @saveUser = (attributes, options)=> user.save attributes, options
    # virtualizes user registration helper method
    @registerUser = (attributes, options)=> @saveUser attributes, options
    # automatically restores session if token is set
    @restore token if token?