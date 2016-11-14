XmlHttpRequestClass = require('xmlhttprequest').XMLHttpRequest
HttpBrowserWrapper = require '../src/browser/HttpBrowserWrapper'
should = require('should')

requester = new HttpBrowserWrapper(new XmlHttpRequestClass())

describe 'Browser Based Http Request', ->

    it 'can Store, Get and Delete Data on Object', (done) ->

        # sample unit test
        a =
            method:'GET'
            port:80
            path:''
            hostname:'api.moj.io'
            scheme: 'http'
            data:
                a:1

        requester.request(a, (error, result) ->
            (error==null).should.be.true
            (result?).should.be.true
            done()
        )
