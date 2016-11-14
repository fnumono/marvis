MojioModel = require('./MojioModel')

module.exports = class Trip extends MojioModel
    # instance variables
    _schema:             {
                "Type": "Integer",
                "MojioId": "String",
                "VehicleId": "String",
                "StartTime": "String",
                "LastUpdatedTime": "String",
                "EndTime": "String",
                "MaxSpeed": "Float",
                "MaxAcceleration": "Float",
                "MaxDeceleration": "Float",
                "MaxRPM": "Integer",
                "FuelLevel": "Float",
                "FuelEfficiency": "Float",
                "Distance": "Float",
                "MovingTime": "Float",
                "IdleTime": "Float",
                "StopTime": "Float",
                "StartLocation": {
                    "Lat": "Float",
                    "Lng": "Float",
                    "FromLockedGPS": "Boolean",
                    "Dilution": "Float"
                },
                "LastKnownLocation": {
                    "Lat": "Float",
                    "Lng": "Float",
                    "FromLockedGPS": "Boolean",
                    "Dilution": "Float"
                },
                "EndLocation": {
                    "Lat": "Float",
                    "Lng": "Float",
                    "FromLockedGPS": "Boolean",
                    "Dilution": "Float"
                },
                "StartAddress": {
                    "Address1": "String",
                    "Address2": "String",
                    "City": "String",
                    "State": "String",
                    "Zip": "String",
                    "Country": "String"
                },
                "EndAddress": {
                    "Address1": "String",
                    "Address2": "String",
                    "City": "String",
                    "State": "String",
                    "Zip": "String",
                    "Country": "String"
                },
                "ForcefullyEnded": "Boolean",
                "StartMilage": "Float",
                "EndMilage": "Float",
                "StartOdometer": "Float",
                "_id": "String",
                "_deleted": "Boolean"
            }

    _resource: 'Trips'
    _model: 'Trip'

    constructor: (json) ->
        super(json)

    # class variables and functions
    @_resource: 'Trips'
    @_model: 'Trip'

    @resource: () ->
        return Trip._resource

    @model: () ->
        return Trip._model

