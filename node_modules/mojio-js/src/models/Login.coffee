MojioModel = require('./MojioModel')

module.exports = class Login extends MojioModel
    # instance variables
    _schema:             {
                "Type": "String",
                "AppId": "String",
                "UserId": "String",
                "ValidUntil": "String",
                "Scopes": "String",
                "Sandboxed": "Boolean",
                "Depricated": "Boolean",
                "_id": "String",
                "_deleted": "Boolean"
            }

    _resource: 'Login'
    _model: 'Login'

    constructor: (json) ->
        super(json)

    # class variables and functions
    @_resource: 'Login'
    @_model: 'Login'

    @resource: () ->
        return Login._resource

    @model: () ->
        return Login._model

