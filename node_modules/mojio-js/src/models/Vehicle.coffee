MojioModel = require('./MojioModel')

module.exports = class Vehicle extends MojioModel
    # instance variables
    _schema:             {
                "Type": "Integer",
                "OwnerId": "String",
                "MojioId": "String",
                "Name": "String",
                "VIN": "String",
                "LicensePlate": "String",
                "IgnitionOn": "Boolean",
                "VehicleTime": "String",
                "LastTripEvent": "String",
                "LastLocationTime": "String",
                "LastLocation": {
                    "Lat": "Float",
                    "Lng": "Float",
                    "FromLockedGPS": "Boolean",
                    "Dilution": "Float"
                },
                "LastSpeed": "Float",
                "FuelLevel": "Float",
                "LastAcceleration": "Float",
                "LastAccelerometer": "Object",
                "LastAltitude": "Float",
                "LastBatteryVoltage": "Float",
                "LastDistance": "Float",
                "LastHeading": "Float",
                "LastVirtualOdometer": "Float",
                "LastOdometer": "Float",
                "LastRpm": "Float",
                "LastFuelEfficiency": "Float",
                "CurrentTrip": "String",
                "LastTrip": "String",
                "LastContactTime": "String",
                "MilStatus": "Boolean",
                "DiagnosticCodes": "Object",
                "FaultsDetected": "Boolean",
                "LastLocationTimes": "Array",
                "LastLocations": "Array",
                "LastSpeeds": "Array",
                "LastHeadings": "Array",
                "LastAltitudes": "Array",
                "Viewers": "Array",
                "_id": "String",
                "_deleted": "Boolean"
            }

    _resource: 'Vehicles'
    _model: 'Vehicle'

    constructor: (json) ->
        super(json)

    # class variables and functions
    @_resource: 'Vehicles'
    @_model: 'Vehicle'

    @resource: () ->
        return Vehicle._resource

    @model: () ->
        return Vehicle._model

