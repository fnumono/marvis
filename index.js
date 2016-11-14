var config = require('./config');
var getConnection = require('./connection');

//Depedency setup
var express = require('express');
var google = require('googleapis');
var date = require('datejs');
var twilio = require('twilio');
var request = require('request');


//alexa
//var Alexa = require('alexa-sdk');
// var Data = require("./data");
 
// const skillName = "The Polyglot";

//Initialization
var app = express();
var calendar = google.calendar('v3');
var oAuthClient = new google.auth.OAuth2(config.googleConfig.clientID, config.googleConfig.clientSecret, config.googleConfig.redirectURL);
var tokenUtils = require('./token-utils')(oAuthClient);

// Schedule setup
var jobSchedule = require('./job-schedule.js'),
  smsJob = require('./jobs/send-sms.js'),
  callJob = require('./jobs/start-call.js');

var CalendarEvent = function (id, description, location, startTime)
{
	this.id = id;
	this.eventName = description;
	this.number = location;
	this.eventTime = Date.parse(startTime);
	this.smsTime = Date.parse(startTime).addMinutes(-1);
}


// var options = {
//   url: "https://api.moj.io/v2/users/",
//   headers: 
//   {
//     'content-type':  "application/json; charset=utf-8",
//     'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
//   }
// };

// function callback(error, response, body) {
//   if (!error && response.statusCode == 200) {
//     var info = JSON.parse(body);
//     console.log(JSON.stringify(body));
//   }
// }

// request(options, callback);




//alexa
// var handlers = {
 
//     "LanguageIntent": function () {
//         function getRandomInt(min, max) {
//             return Math.floor(Math.random() * (max - min)) + min;
//         }
//         var speechOutput = "";
//         if(this.event.request.intent.slots.Language.value && this.event.request.intent.slots.Language.value.toLowerCase() == "java") {
//             speechOutput = Data.java[getRandomInt(0, 2)];
//         } else if(this.event.request.intent.slots.Language.value && this.event.request.intent.slots.Language.value.toLowerCase() == "ionic framework") {
//             speechOutput = Data.ionic[getRandomInt(0, 3)];
//         } else {
//             speechOutput = "I don't have anything interesting to share regarding what you've asked."
//         }
//         this.emit(':tellWithCard', speechOutput, skillName, speechOutput);
//     },
 
//     "AboutIntent": function () {
//         var speechOutput = "The Polyglot Developer, Nic Raboy, is from San Francisco, California";
//         this.emit(':tellWithCard', speechOutput, skillName, speechOutput);
//     },
 
//     "AMAZON.HelpIntent": function () {
//         var speechOutput = "";
//         speechOutput += "Here are some things you can say: ";
//         speechOutput += "Tell me something interesting about Java. ";
//         speechOutput += "Tell me about the skill developer. ";
//         speechOutput += "You can also say stop if you're done. ";
//         speechOutput += "So how can I help?";
//         this.emit(':ask', speechOutput, speechOutput);
//     },
 
//     "AMAZON.StopIntent": function () {
//         var speechOutput = "Goodbye";
//         this.emit(':tell', speechOutput);
//     },
 
//     "AMAZON.CancelIntent": function () {
//         var speechOutput = "Goodbye";
//         this.emit(':tell', speechOutput);
//     },
 
//     "LaunchRequest": function () {
//         var speechText = "";
//         speechText += "Welcome to " + skillName + ".  ";
//         speechText += "You can ask a question like, tell me something interesting about Java.  ";
//         var repromptText = "For instructions on what you can say, please say help me.";
//         this.emit(':ask', speechText, repromptText);
//     }
 
// };
 
// exports.handler = function (event, context) {
//     var alexa = Alexa.handler(event, context);
//     alexa.appId = "amzn1.ask.skill.cd40a162-5093-45fa-ad4e-022459fe8ab2";
//     alexa.registerHandlers(handlers);
//     alexa.execute();
// };

////////////////////////////////////////////////////////////////////////////////


app.set('view engine', 'ejs');
app.use(express.static("public"));

function fetchAndSchedule() {
  // Set obj variables
  var id, eventName, number, start;
 
  // Call google to fetch events for today on our calendar
  calendar.events.list({
    calendarId: config.googleConfig.calendarId,
    maxResults: 20,
    timeMax: Date.parse('tommorow').addSeconds(-1).toISOString(), // any entries until the end of today
    updatedMin: new Date().clearTime().toISOString(), // that have been created today
    auth: oAuthClient
  }, function(err, events) {
    if (err) {
      console.log('Error fetching events');
      console.log(err);
    } else {
      // Send our JSON response back to the browser
      console.log('Successfully fetched events');
 	  console.log('There are ' + events.items.length + " events");
      for (var i = 0; i < events.items.length; i++) {
      	console.log(i);
      	console.log(events.items[i].summary);
        // populate CalendarEvent object with the event info
        event = new CalendarEvent(events.items[i].id, events.items[i].summary, events.items[i].location, events.items[i].start.dateTime);
 
        // Filter results 
        // ones with telephone numbers in them 
        // that are happening in the future (current time < event time)
        //if (event.number.match(/\+[0-9 ]+/) && (Date.compare(Date.today().setTimeToNow(), Date.parse(event.eventTime)) == -1)) {
 
          // SMS Job
          smsJob.send(jobSchedule.agenda, event, 'sms#1', config.ownNumber);
 
          // Call Job
          callJob.call(jobSchedule.agenda, event, "call#1", config.ownNumber);
        //}
      }


          //smsJob.send(jobSchedule.agenda, event, 'sms#1', config.ownNumber);
 
    }
  });
}

app.get('/greeting', function(req,res){
  res.render('index',{user: "Great User",title:"homepage"});
});

app.get('/users', function(req,res){
  var options = {
  url: "https://api.moj.io/v2/users/",
  headers: 
  {
    'content-type':  "application/json; charset=utf-8",
    'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
  }
};

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    console.log(JSON.stringify(body));
  }
}

request(options, callback);


});


app.get('/vehicles', function(req,res){
  var options = {
  url: "https://api.moj.io/v2/vehicles/",
  headers: 
  {
    'content-type':  "application/json; charset=utf-8",
    'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
  }
};

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    //console.log(JSON.stringify(body));
    //console.log(info.Data);
    //console.log(info.Data.length);
    res.render('vehicles', {vehicles: info});
  }
}

request(options, callback);

  // var json = {
  //   Data: 
  //   [ { Name: 'pram',
  //       Speed: 50
  //     },
  //     {
  //       Name: 'Rob',
  //       Speed: 30
  //     },
  //     {
  //       Name: 'Shella',
  //       Speed: 100
  //     }
  //   ], Results: 1
  // }

  // var data = json;
  // console.log (data);
  // console.log (data.Data.length);



  // res.render('vehicles', {vehicles: json});


});

app.get('/testtwilio', function(req,res){
  var client = twilio('AC08a299c2f54ab987129385c47921fb17', '9ef1566a32704435d609ae3315d8b485');
 
// Send the text message.
client.sendMessage({
  to: '14084253396',
  from: '16692363597',
  body: 'Dont Speed and your gas'
});

}); 

// df29c323-ae8e-4f9a-a86a-3e23e7ebdf38

app.get('/health/:id', function(req,res){
 
  var options = {
  url: "https://api.moj.io/v2/vehicles/" + req.params.id,
    headers: 
    {
      'content-type':  "application/json; charset=utf-8",
      'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
    }
  };

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    //console.log(info.VIN);
    console.log(info);
    res.render('health',{vehicle: info});
  }
}

request(options, callback);

});


app.get('/emergency/:id', function(req,res){
 
  var options = {
  url: "https://api.moj.io/v2/vehicles/" + req.params.id,
    headers: 
    {
      'content-type':  "application/json; charset=utf-8",
      'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
    }
  };

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    //console.log(info.VIN);
    console.log(info);
    res.render('emergency',{vehicle: info});
  }
}

request(options, callback);

});



app.get('/insurance/:id', function(req,res){
  var id = req.param.id;

   var options = {
  url: "https://api.moj.io/v2/vehicles/" + req.params.id,
    headers: 
    {
      'content-type':  "application/json; charset=utf-8",
      'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
    }
  };

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var vehicle = JSON.parse(body);
    //console.log(info.VIN);
    //console.log(info);
    res.render('insurance',vehicle);
  }
}

request(options, callback);

});


app.get('/mechanics/:id', function(req,res){
  var id = req.param.id;

   var options = {
  url: "https://api.moj.io/v2/vehicles/" + req.params.id,
    headers: 
    {
      'content-type':  "application/json; charset=utf-8",
      'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
    }
  };

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var vehicle = JSON.parse(body);
    //console.log(info.VIN);
    //console.log(info);
    res.render('mechanics',vehicle);
  }
}

request(options, callback);

});

app.get('/gas/:id', function(req,res){
  var id = req.param.id;

   var options = {
  url: "https://api.moj.io/v2/vehicles/" + req.params.id,
    headers: 
    {
      'content-type':  "application/json; charset=utf-8",
      'Authorization': 'Bearer 80dd40cd-b415-469a-8e06-8e08444b81ad'
    }
  };

function callback(error, response, body) {
  if (!error && response.statusCode == 200) {
    var vehicle = JSON.parse(body);
    //console.log(info.VIN);
    //console.log(info);
    res.render('gas',vehicle);
  }
}

request(options, callback);

});


app.get('/home', function(req,res){
  res.render('index',{user: "Pramono",title:"Marvis"});
});

app.post('/call', function(req, res) {
  var number = req.query.number;
  var eventName = req.query.eventName;
  var resp = new twilio.TwimlResponse();
  resp.say('Your meeting ' + eventName + ' is starting.', {
    voice: 'alice',
    language: 'en-gb'
  }).dial(number);
 
  res.writeHead(200, {
    'Content-Type': 'text/xml'
  });
  res.end(resp.toString());
});





app.get('/', function(req,res){
	// res.send('Hello world');
	//do something more meaningful

	getConnection(function(err, db) {
    var collection = db.collection("tokens");
    collection.findOne({}, function(err, tokens) {
      // Check for results
      if (tokens) {
        // If going through here always refresh
        tokenUtils.refreshToken(tokens.refresh_token);
        res.send('authenticated');
      } else {
        tokenUtils.requestToken(res);
      }
    });
  });
});

app.get('/auth', function(req,res){
	var code = req.query.code;
	

	  if (code) {
	    tokenUtils.authenticateWithCode(code, function(err, data) {
	      if (err) {
	        console.log(err);
	      } else {
	        res.redirect('/');
	      }
	    });
	  }

});

var server = app.listen(config.port, function() {
  var host = server.address().address;
  var port = server.address().port;

 	// make sure user is authenticated but check for existing tokens first
  getConnection(function(err, db) {
    var collection = db.collection("tokens");
    collection.findOne({}, function(err, tokens) {
      if (tokens) {
        tokenUtils.authenticateWithDB();
      }
    });
  });

   jobSchedule.agenda.define('fetch events', function(job, done) {
    fetchAndSchedule();
    done();
  });
 
  jobSchedule.agenda.every('30 seconds', 'fetch events');
 
  // Initialize the task scheduler
  jobSchedule.agenda.start();


 
  console.log('Listening at http://%s:%s', host, port);
});