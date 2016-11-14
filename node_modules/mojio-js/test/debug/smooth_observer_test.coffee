MojioClient = require '../../src/nodejs/MojioClient'
Observer = require '../../src/models/Observer'
App = require '../../src/models/App'
Mojio = require '../../src/models/Mojio'
Vehicle = require '../../src/models/Vehicle'
Event = require '../../src/models/Event'
User = require '../../src/models/User'
config = require '../config/mojio-config.coffee'
mojio_client = new MojioClient(config)
assert = require('assert')
testdata = require('../data/mojio-test-data')
should = require('should')
count = [0,0]

observer = null
theevent = null
vehicle = null
user = null

describe 'Smooth Observer', ->

    before( (done) ->
        mojio_client.login(testdata.username, testdata.password, (error, result) ->
            (error==null).should.be.true
            done()
        )
    )
    #
    it 'Can Smooth Observe Vehicles', (done) ->
        user = new User({})
        user.authorization(mojio_client)

        user.query({}, (error, result) ->
            (error==null).should.be.true
            mojio_client.should.be.an.instanceOf(MojioClient)
            result.Objects.should.be.an.instanceOf(Array)
            instance.should.be.an.instanceOf(User) for instance in result.Objects
            user = result.Objects[0]
            mojio = new Mojio().mock()
            mojio.OwnerId = user.id
            mojio_client.post(mojio, (error, result) ->
                (error==null).should.be.true
                mojio = new Vehicle(result)

                vehicle = new Vehicle().mock()
                vehicle.MojioId = mojio._id
                vehicle.OwnerId = user._id
                vehicle.LastSpeed = 20.0;

                mojio_client.post(vehicle, (error, result) ->
                    (error==null).should.be.true
                    vehicle = new Vehicle(result)
                    console.log("created vehicle"+vehicle)
                    observer = new Observer(
                        {
                            ObserverType: "SmoothVehicle", Status: "Approved", SpeedLow: 80.0, Name: "Test"+Math.random(),
                            Subject: vehicle.model(), SubjectId: vehicle.id(), "Transports": "SignalR"
                        }
                    )
                    mojio_client.watch(observer,
                    (entity) ->
                        entity.should.be.an.instanceOf(Object)
                        console.log("Observed change seen.")
                        mojio_client.unobserve(observer, vehicle, null, null, (error, result) ->
                            mojio_client.delete(vehicle, (error, result) ->
                                (error==null).should.be.true
                                console.log("Vehicle deleted.")
                                done()
                            )
                        )
                    ,
                    (error, result) ->
                        result.should.be.an.instanceOf(Observer)
                        result.Status.should.equal("Approved")

                        vehicle.LastSpeed = 90.0
                        console.log("changing vehicle speed...")
                        observer = result
                        event = new Event({})
                        event.authorization(mojio_client)
                        event.EventType = "TripEvent"
                        event.VehicleId = vehicle._id
                        event.MojioId = mojio._id
                        event.Speed = 90.0
                        mojio_client.post(event, (error, result) ->
                            (error==null).should.be.true
                            console.log("Event at speed 90.0 added.")
                        )
                    )
                )
            )
        )