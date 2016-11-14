MojioClient = @MojioClient

###

    Below, fill in your application specific details to make this code work

config =
    application: 'Your-Application-Key-Here' # Fill in your application key here (replace Your-Application-Key-Here)
    secret: 'Your-Secret-Key-Here' # Fill in your secret key here. (replace Your-Secret-Key-Here)
    login: 'Your-Username' <-- Replace
    password: 'Your-Password' <-- Replace
    live: false # Set to true if using the live environment

###
config =
    application: 'Your-Application-Key-Here'
    secret: 'Your-Secret-Key-Here'
    hostname: 'api.moj.io'
    version: 'v1'
    port: '443'
    scheme: 'https'
    live: false
    login: 'Your-Username'
    password: 'Your-Password'
    live: false

mojio_client = new MojioClient(config)
App = mojio_client.model('App')
Vehicle = mojio_client.model('Vehicle')
Mojio = mojio_client.model('Mojio')
Event = mojio_client.model('Event')

$( () ->

    eventChangedCallback = (entity) ->
        div = document.getElementById('result7')
        div.innerHTML += 'Observed /Event <br>'
        div.innerHTML += JSON.stringify(entity)
        console.log("Observed Event! "+entity)

    if (config.application == 'Your-Sandbox-Application-Key-Here')
        div = document.getElementById('result')
        div.innerHTML += 'Mojio Error:: Set your application and secret keys in login.js.  <br>'
        return

    if (config.login == 'Your-Username')
        div = document.getElementById('result2')
        div.innerHTML += 'Mojio Error:: Set a username and password in login.js.  <br>'
        return

    mojio_client.login(config.login, config.password, (error, result) ->
        if (error)
            alert("Login Error:"+error)
        else
            extractToken = (hash) ->
                match = hash.match(/access_token=([0-9a-f-]{36})/)
                return !!match && match[1]
            token = extractToken(document.location.hash)
            div = document.getElementById('result')
            div.innerHTML += 'POST /login<br>'
            div.innerHTML += '<br>Token: '+token+'<br>'
            div.innerHTML += JSON.stringify(result)
            mojio_client.query(Vehicle, {}, (error, result) ->
                if (error)
                    div = document.getElementById('result2')
                    div.innerHTML += 'Get Vehicle Error'+error+'<br>'
                else
                    vehicles = mojio_client.getResults(Vehicle, result)

                    vehicle = vehicles[0]
                    div = document.getElementById('result2')
                    div.innerHTML += 'Query /Vehicle<br>'
                    div.innerHTML += JSON.stringify(result)

                    console.log("Observing vehicle's events")

                    mojio_client.observe(vehicle, "TripStatus",
                        eventChangedCallback
                    ,
                    (error, result) ->
                        if (error)
                            console.log("error:"+error)
                        else
                            console.log("Observing of vehicle's events started!")
                    )
            )
    )
)

