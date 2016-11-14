var config = require('./config');
var MongoClient = require('mongodb').MongoClient;

var dbSingleton = null;

var getConnection = function getConnection(callback)
{
	if (dbSingleton){
		callback(null, dbSingleton);
	}
	else
	{
		var connURL = 'mongodb://user:password@ds151117.mlab.com:51117/oauth';
		MongoClient.connect(connURL, function(err,db){
			if (err)
			{
				console.log("Error creating new connection " + err);
			}
			else
			{
				dbSingleton = db;
				console.log("created new connection");
			}

		callback(err, dbSingleton);
		return;
		});
	}
}

module.exports = getConnection;