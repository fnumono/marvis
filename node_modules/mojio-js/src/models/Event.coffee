MojioModel = require('./MojioModel')

module.exports = class Event extends MojioModel
    # instance variables
    _schema:             {
                "Type": "Integer",
                "MojioId": "String",
                "VehicleId": "String",
                "OwnerId": "String",
                "EventType": "Integer",
                "Time": "String",
                "Location": {
                    "Lat": "Float",
                    "Lng": "Float",
                    "FromLockedGPS": "Boolean",
                    "Dilution": "Float"
                },
                "TimeIsApprox": "Boolean",
                "BatteryVoltage": "Float",
                "ConnectionLost": "Boolean",
                "_id": "String",
                "_deleted": "Boolean",
                "Accelerometer": {
                    "X": "Float",
                    "Y": "Float",
                    "Z": "Float"
                },
                "TripId": "String",
                "Altitude": "Float",
                "Heading": "Float",
                "Distance": "Float",
                "FuelLevel": "Float",
                "FuelEfficiency": "Float",
                "Speed": "Float",
                "Acceleration": "Float",
                "Deceleration": "Float",
                "Odometer": "Float",
                "RPM": "Integer",
                "DTCs": "Array",
                "MilStatus": "Boolean",
                "Force": "Float",
                "MaxSpeed": "Float",
                "AverageSpeed": "Float",
                "MovingTime": "Float",
                "IdleTime": "Float",
                "StopTime": "Float",
                "MaxRPM": "Float",
                "EventTypes": "Array",
                "Timing": "Integer",
                "Name": "String",
                "ObserverType": "Integer",
                "AppId": "String",
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
                "NextAllowedBroadcast": "String"
            }

    _resource: 'Events'
    _model: 'Event'

    constructor: (json) ->
        super(json)

    # class variables and functions
    @_resource: 'Events'
    @_model: 'Event'

    @resource: () ->
        return Event._resource

    @model: () ->
        return Event._model

