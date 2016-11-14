var request = require('request');
var http = require('http');
 
// var accessToken = 'ACCESS_TOKEN_HERE';
 
// request({
//   url: 'https://api.someapi.com/blah/something',
//   auth: {
//     'tokenHost': 'https://api.moj.io/OAuth2/authorize'
//   }
// }, function(err, res) {
//   console.log(res.body);
// });
 

// request.post({url: 'https://accounts.moj.io/OAuth2/token', form: { grant_type: 'password', 
//                                                   username: 'wangpramono@gmail.com',
//                                                   password: 'tUmbuhan1',
//                                                   client_id: 'fcd897e4-640c-4330-8746-f04bb1f990af',
//                                                   client_secret: '5481000f-d421-4431-a22e-b2a99de95ce5'
//                                                   }}, function(error, response, body){
//                                                     if (error){
//                                                       console.log(error);
//                                                     }
//                                                     else
//                                                     {
//                                                       console.log(response.statusCode, body);
//                                                      data = JSON.parse(body);
//                                                      console.log(data);
//                                                      mojioAPIToken = data["access_token"];
//                                                     }
//                                                   });


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// var options = {
//   url: "https://api.moj.io/v2/users/",
//   headers: 
//   {
//     'content-type':  "application/json; charset=utf-8",
//     'Authorization': 'Bearer 9f7478bd-aa77-4b98-a2b1-226472fc41c3'
//   }
// };

// function callback(error, response, body) {
//   if (!error && response.statusCode == 200) {
//     var info = JSON.parse(body);
//     console.log(JSON.stringify(body));
//   }
// }

// request(options, callback);

http.get('http://api.moj.io/v2/vehicles', {
    headers: {'Authorization': 'Bearer 9f7478bd-aa77-4b98-a2b1-226472fc41c3'}
}, function (err, response){
    if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    console.log(JSON.stringify(body));
  }
});


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// request({
//     method: 'PPOST',
//     url: 'https://api.moj.io/OAuth2/token', //URL to hit
//     body: {

//     }
//       client_id : 'fcd897e4-640c-4330-8746-f04bb1f990af',
//       redirect_uri : 'https://api.moj.io'
    
// }, function(error, response, body){
//     if(error) {
//         console.log(error);
//     } else {
//         console.log(response.statusCode, body);
//     }
// });

// Set the configuration settings
// const credentials = {
//   client: {
//     id: 'fcd897e4-640c-4330-8746-f04bb1f990af',
//     secret: '5481000f-d421-4431-a22e-b2a99de95ce5'
//   },
//   auth: {
//     tokenHost: 'https://api.moj.io/OAuth2/authorize'
//   }
// };

// // Initialize the OAuth2 Library
// const oauth2 = require('simple-oauth2').create(credentials);

// // Authorization oauth2 URI
// const authorizationUri = oauth2.authorizationCode.authorizeURL({
//   redirect_uri: 'http://api.moj.io',
//   scope: '<scope>',
//   state: '<state>'
// });

// // Redirect example using Express (see http://expressjs.com/api.html#res.redirect)
// res.redirect(authorizationUri);

// // Get the access token object (the authorization code is given from the previous step).
// const tokenConfig = {
//   code: '<code>',
//   redirect_uri: 'http://api.moj.io'
// };

// // Callbacks
// // Save the access token
// oauth2.authorizationCode.getToken(tokenConfig, function (error, result) {
//   if (error) {
//     return console.log('Access Token Error', error.message);
//   }

//   const token = oauth2.accessToken.create(result);
// });

// // Promises
// // Save the access token
// oauth2.authorizationCode.getToken(tokenConfig)
// .then(function (result)  {
//   const token = oauth2.accessToken.create(result);
// })
// .catch(function (error) {
//   console.log('Access Token Error', error.message);
// });