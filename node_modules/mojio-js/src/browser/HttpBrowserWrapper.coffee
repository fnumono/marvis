module.exports = class HttpBrowserWrapper

    constructor: (requester=null) ->
        @requester = requester if requester?

    request: (params, callback) ->
        params.method = "GET" unless params.method?
        params.host = params.hostname if (!params.host? and params.hostname?)
        params.scheme = window.location.protocol.split(':')[0] unless params.scheme? || !window?

        params.scheme = 'https' if !params.scheme || params.scheme == 'file'

        params.data = {} unless params.data?
        params.data = params.body if params.body?



        params.headers = {} unless params.headers?

        url = params.scheme+"://"+params.host+":"+params.port+params.path

        if params.method == "GET" and params.data? and params.data.length > 0
          url +='?' + Object.keys(params.data).map( (k) ->
            return encodeURIComponent(k) + '=' + encodeURIComponent(params.data[k])
          ).join('&')


        if (XMLHttpRequest?)
            xmlhttp = new XMLHttpRequest
        else
            xmlhttp = @requester
        xmlhttp.open params.method , url ,true

        for k,v of params.headers
            xmlhttp.setRequestHeader k, v

        xmlhttp.onreadystatechange=() ->
            if xmlhttp.readyState==4
                if (xmlhttp.status >= 200 and xmlhttp.status <= 299)
                    callback(null,JSON.parse xmlhttp.responseText)
                else
                    callback(xmlhttp.statusText,null)

        if params.method == "GET"
            xmlhttp.send()
        else
            xmlhttp.send(params.data)
