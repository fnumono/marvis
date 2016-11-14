#MojioClient = require '../../lib/nodejs/MojioClient'
#Vehicle = require '../../lib/models/Vehicle'
#Trip = require '../../lib/models/Trip'
#Mojio = require '../../lib/models/Mojio'
#config = require '../config/mojio-config.coffee'
#config.application = '6457d3dc-32f1-4f47-b030-211bc5544533'
#config.secret = '35bf63e7-4443-4883-8d46-1e9195dec800'
#config.live = false
#
#mojio_client = new MojioClient(config)
#assert = require('assert')
#testdata = require('../data/mojio-test-data')
#testdata.username = 'anonymous'
#testdata.password = 'Password007'
#
#should = require('should')
#
#testObject = null
#
#describe 'Vehicle', ->
#
#    before( (done) ->
#        mojio_client.login(testdata.username, testdata.password, (error, result) ->
#            (error==null).should.be.true
#            mojio_client.getCurrentUser((error, result) ->
#                (error==null).should.be.true
#            )
#            done()
#        )
#    )
#
#    it 'can get Vehicles and get a vehicle by id and criteria', (done) ->
#
#        mojio_client.get(Vehicle, {}, (error, result) ->
#            (error==null).should.be.true
#            mojio_client.should.be.an.instanceOf(MojioClient)
#            result.Objects.should.be.an.instanceOf(Array)
#            instance.should.be.an.instanceOf(Vehicle) for instance in result.Objects
#            vehicle = result.Objects[0]
#            mojio_client.get(Vehicle, "f7fd11ba-3a0a-4f8c-9a21-08c5605ca718", (error, result) ->
#                result.should.be.an.instanceOf(Vehicle)
#                mojio_client.get(Trip, {criteria: {VehicleId: result.id()}}, (error, result) ->
#                    result.Objects.should.be.an.instanceOf(Array)
#                    instance.should.be.an.instanceOf(Trip) for instance in result.Objects
#                    done()
#                )
#            )
#
#        )
