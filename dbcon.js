/*jslint node: true */
"use strict";

//var dbUser = 'pegasus';
var dbUser = 'chrishanagan';

process.env.NODE_PORT = 3001;
process.env.HELIOSDB_HOST = 'localhost';
process.env.HELIOSDB_PORT = 5432;
process.env.HELIOSDB_NAME = dbUser;
process.env.HELIOSDB_USER = dbUser;
process.env.HELIOSDB_PASSWORD = '1q2w3e4r!Q@W#E$R';

var promise = require('bluebird');

var options = {
    // Initialization Options
    promiseLib: promise
};

var pgp = require('pg-promise')(options);

var connection = {
    host: process.env.HELIOSDB_HOST,
    port: process.env.HELIOSDB_PORT,
    database: process.env.HELIOSDB_NAME,
    user: process.env.HELIOSDB_USER,
    password: process.env.HELIOSDB_PASSWORD
};

var dbcon = pgp(connection);

module.exports = {
    dbcon: dbcon,
    pgp: pgp
};