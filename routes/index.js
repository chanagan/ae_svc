var express = require('express');
var router = express.Router();

// used to get app name and version
var pjson = require('../package.json');

// CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
router.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});


/* GET home page. */
router.get('/ae_svc', function(req, res, next) {
    res.render('api', {
        title: pjson.name,
        app: pjson.name,
        version: pjson.version
    });
});

// include the endpoint functions for announcements
var endpoint = require('../endpoint-functions/functions');

router.get('/odin/test', endpoint.testAll);

router.get('/ae_svc/getFlights/:req_date', endpoint.getDayFlights);

module.exports = router;