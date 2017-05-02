class $scope.Schema extends $scope.SchemaRoller.Schema
  constructor:->
    Schema.__super__.constructor.apply @, arguments
  ## virtual
  virtual: (name, options)->
    # virtuals = @virtuals
    # parts    = name.split( '.' )
    # name.split( '.' ).reduce ((mem, part, i, arr)-> console.log arguments), @tree
    # mem[part] || mem[part] = if (i == parts.length-1) then new $scope.VirtualType options, name else {}
    @virtuals[name] = name.split( '.' ).reduce ((mem, part, i, arr)->
      mem[part] || mem[part] = if (i == arr.length-1) then new $scope.VirtualType options, name else {}
    ), @tree
  ## virtualpath
  virtualpath: (name)->
    @virtuals[name]
## Schema.reserved
$scope.Schema.reserved = _.zipObject _.map """
on,db,set,get,init,isNew,errors,schema,options,modelName,collection,toObject,emit,_events,_pres,_posts
""".split(','), (v)->[v,1]