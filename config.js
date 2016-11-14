var config = {};
 
// HTTP Port to run our web application
config.port = process.env.PORT || 3000;
 
// My own telephone number for notifications and calls
config.ownNumber = '14084253396';
 
// Your Twilio account SID and auth token, both found at:
// https://www.twilio.com/user/account
// A good practice is to store these string values as system environment variables, and load them from there as we are doing below. 
// Alternately, you could hard code these values here as strings.
config.twilioConfig = {
    accountSid: 'AC08a299c2f54ab987129385c47921fb17',
    authToken: '9ef1566a32704435d609ae3315d8b485',
    // A Twilio number you control - choose one from:
    // https://www.twilio.com/user/account/phone-numbers/incoming
    number: '16692363597'
  }
// Google OAuth Configuration
config.googleConfig = {
  clientID: '857836012575-7pefrrdd58g4ecri0pnpaf4iqd7nlht5.apps.googleusercontent.com',
  clientSecret: 'uEW_2iAxakr_60xVmsga_ov5',
  calendarId: 'wangpramono@gmail.com',
  // same as configured at the Developer Console
  redirectURL: 'http://localhost:3000/auth'
};
// MongoDB Settings
config.mongoConfig = {
    ip: '127.0.0.1',
    port: 27017,
    name: 'twilio-pa'
  }
// Export configuration object
module.exports = config;
