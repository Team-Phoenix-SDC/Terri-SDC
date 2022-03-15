
const pgp = require('pg-promise')() // currying both requires and invokes 'pg-promise'
const pool = require('../config.js')

const db = pgp(pool);

// app.get("/", (req, res) => {
  //   res.send("this is working!")
  // })

  module.exports = db;


  // console.log("do these endpoints look right??????????????", pool)

  // pool.connect()
  // pool.query('SELECT NOW()', (err, res) => {

    //   console.log("there was an error!!!!!!!", err)
    //   console.log("THIS WAS THE RESPONSE", res)
    //   pool.end()
    // })


    // const { Pool, Client } = require('pg')

    // pools will use environment variables
    // for connection information

    //PGHOST='localhost'
    // PGUSER=process.env.USER
    // PGDATABASE=process.env.postgres
    // PGPORT=5432