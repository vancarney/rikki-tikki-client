#### RikkiTikki.Query
#> Provides singleton access to virtualized Backbone.Router instance
class RikkiTikki.Router extends RikkiTikki.Singleton
  #### constructor()
  # > Class Constructor Method
  constructor:->
    # virtualizes an instance of Bbackbone.Router
    _router = new Backbone.Router
    #### RikkiTikki.Router.routes( object )
    # > sets routes on Router instance
    RikkiTikki.Router::routes = (r)=>
      # invokes routes with args
      _router.routes r
    #### RikkiTikki.Router.routes( route, name, callback )
    # > adds a route to the Router instance
    RikkiTikki.Router::route = (r,n,cB)=>
      # invokes route with args
      _router.route r,n,cB
    #### RikkiTikki.Router.navigte( path, opts )
    # > navigates to the given path
    RikkiTikki.Router::navigate = (p,opts)=>
      # invokes navigate with args
      _router.navigate p,opts
    #### RikkiTikki.Router.execute( callback, args )
    # > executes the matching callback
    RikkiTikki.Router::execute = (cB, args)=>
      # invokes execute with args
      _router.execute cB, args
#### RikkiTikki.Router.getInstance()
# > returns instance of Router
RikkiTikki.Router.getInstance = =>
  @__instance ?= new RikkiTikki.Router()