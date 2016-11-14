SignalR = require 'signalr-client'
module.exports = class SignalRNodeWrapper

    observer_callbacks:  {}

    observer_registry: (entity) =>
        # need to have the observer id to look this up here.
        # could use the entity type
        if @observer_callbacks[entity._id]
            callback(entity) for callback in @observer_callbacks[entity._id]
        else if @observer_callbacks[entity.Type]
            callback(entity) for callback in @observer_callbacks[entity.Type]

    constructor: (url, hubNames, jquery = null) ->
        @url = url
        @hubs = {}

        @available_hubs = hubNames
            
    getHub: (which, callback, retries = 10) ->
        @signalr ?= new SignalR.client(@url, @available_hubs, null)

        return callback(null, @hubs[which]) if @hubs[which]?
        
        if @hubs[which] = @signalr.hub(which)
            @hubs[which].on 'error', (data) -> log data
            @hubs[which].on 'UpdateEntity', @observer_registry

            return callback null, @hubs[which]
        else if retries-- > 0
            _this = @
            retry = () ->
                _this.getHub which, callback, retries
            setTimeout retry, 1000
        else
            callback "Timed out.", null
              
    # TODO:: move callback list maintenance to separate class.
    setCallback: (id, futureCallback) ->
        if (!@observer_callbacks[id]?)
            @observer_callbacks[id] = []
        @observer_callbacks[id].push(futureCallback)
        return

    removeCallback: (id, pastCallback) ->
        if (pastCallback == null)
            @observer_callbacks[id] = []
        else
            temp = []
            # reform the obxerver_callbacks list without the given pastCallback
            for callback in @observer_callbacks[id]
                temp.push(callback) if (callback != pastCallback)
            @observer_callbacks[id] = temp
        return

    subscribe: (hubName, method, observerId, subject, futureCallback, callback) ->
        @setCallback(subject, futureCallback)
        @getHub(hubName, (error, hub) ->
            if error?
                callback(error, null)
            else
                hub.invoke(method, observerId) if hub?
                callback(null, hub)
        )

    unsubscribe: (hubName, method, observerId, subject, pastCallback, callback) ->
        @removeCallback(subject, pastCallback)
        if (@observer_callbacks[subject].length == 0)
            @getHub(hubName, (error, hub) ->
                if error?
                    callback(error, null)
                else
                    hub.invoke(method, observerId) if hub?
                    callback(null, hub)
            )
        else
            callback(null, true)
