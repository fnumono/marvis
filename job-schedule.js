var Agenda = require("Agenda");
var config = require('./config');
agenda = new Agenda({
	db: {
		address: 'mongodb://user:password@ds151117.mlab.com:51117/oauth'
	}
});

exports.agenda = agenda;