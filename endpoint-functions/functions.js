/*jslint node: true */
/*jshint esversion: 6 */
/**
 * This javascript file will be used to define all of the end points for the
 * service.
 *
 * @module blah
 * @author blash
 */
var path = require('path');

// load database connection
var db = require('../dbcon');

// Helper for linking to external query files:
function sql(file) {
    var sqlFile = path.join(__dirname, '/../sql/', file);
    return new db.pgp.QueryFile(sqlFile, { minify: true });
}


// load sql queries
var sql1 = sql('sql1.sql');
var getFlights = sql('getFlights.sql');

/**
 * The blah method is used to blah
 * deleted_flag is set to N.
 * <br>
 * The end point for this is <b>GET</b> /odin/blah
 *
 * @method blah
 * @param {Object} request the request object
 * @param {Object} response the response object
 * @param {function} callback the node js callback function
 * @return {Object} Returns a json object containing the data
 */
function testAll(request, response, callback) {
    // select all announcements
    db.dbcon.any(sql1)
        //db.any('select * from olympia.announcements where deleted_flag = \'N\'')
        .then(function(data) {
            response.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved data'
                });
        })
        .catch(function(err) {
            return callback(err);
        });
}

function getDayFlights(request, response, callback) {
    var frmDate = request.params.req_date + ' 00:00';
    var toDate = request.params.req_date + ' 23:59';

    db.dbcon.any(getFlights, [frmDate, toDate])
        .then(function(data) {
            response.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Data Retrieved'
                });
        })
        .catch(function(err) {
            return callback(err);
        });
}

// export the functions
module.exports = {
    testAll: testAll,
    getDayFlights: getDayFlights
};