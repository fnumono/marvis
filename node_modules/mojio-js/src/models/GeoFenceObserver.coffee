MojioModel = require('./MojioModel')

module.exports = class GeoFenceObserver extends MojioModel
    # instance variables
    _schema:             {
                "Location": {
                    "Lat": "Float",
                    "Lng": "Float",
                    "FromLockedGPS": "Boolean",
                    "Dilution": "Float"
                },
                "Radius": "Float",
                "Timing": "Integer",
                "Type": "Integer",
                "Name": "String",
                "ObserverType": "Integer",
                "AppId": "String",
                "OwnerId": "String",
                "Parent": "String",
                "ParentId": "String",
                "Subject": "String",
                "SubjectId": "String",
                "Transports": "Integer",
                "Status": "Integer",
                "Tokens": "Array",
                "TimeWindow": "String",
                "BroadcastOnlyRecent": "Boolean",
                "Throttle": "String",
                "NextAllowedBroadcast": "String",
                "_id": "String",
                "_deleted": "Boolean"
            }

    _resource: 'GeoFenceObservers'
    _model: 'GeoFenceObserver'

    constructor: (json) ->
        super(json)

    # class variables and functions
    @_resource: 'GeoFenceObservers'
    @_model: 'GeoFenceObserver'

    @resource: () ->
        return GeoFenceObserver._resource

    @model: () ->
        return GeoFenceObserver._model

