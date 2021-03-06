class $scope.OP extends Object
  constructor:(@parent)->
    throw "No Parent Class provided to new instance of #{namespace}.OP" unless @parent
  __op:{}
  toJSON: -> @__op
  __addOp:(attr, type, aName, obj)->
    if (val = @parent.get 'attr')?
      (op = __op: type)[aName] = obj
      (@__op[attr] || @__op[attr] = []).push op
      @parent.__isDirty = true
    val
  addRelation: (attr,obj) -> 
    @__addOp attr, 'AddRelation', 'objects', _compact _.map (if _.isArray obj then obj else [obj]), (v,k) ->
      if v._toPointer then v._toPointer() else null
  #### removeRelation(attr,objects)
  # > Removes passed object Relations from the owner object
  removeRelation: (attr,obj) -> @__addOp attr, 'RemoveRelation', 'objects', if _.isArray obj then obj else [obj]
  #### relation(attr)
  # > Returns a new Relation Object bound to the specified attribute
  relation: (attr)->
    throw "#{namespace}.Relation requires an attribute" unless attr
    throw "No Parent Class defined on instance of #{namespace}.OP" unless @parent
    if (rel = @parent.get attr)?
      throw 'called relation() on a non-relation field' unless (val instance of $scope.Relation)
      rel._ensureParentAndKey @parent, attr
    else
      rel = _.extend (new $scope.Relation @parent, attr),
        add:(obj) => @addRelation attr, rel
        remove:(obj) => @removeRelation attr, rel
    rel