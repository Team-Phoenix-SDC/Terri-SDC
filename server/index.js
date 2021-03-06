const express = require("express");
const db = require("../database/index.js");
const app = express();
const path = require("path");
const port = process.env.PORT || 3000;

// const DIST_DIR = path.join(__dirname, "dist");
// const HTML_FILE = path.join(DIST_DIR, "index.html");

app.use(express.json());
// app.use(express.static("public"));
// app.use(express.static("dist"));

// test case
app.get("/", (req, res) => {
   res.send("this is working!")
})

// async must be at highest level of function
app.get('/products/:product_id', async (req, res) => {
   let productObj = {};
   // to handle errors, use try/catch blocks

   console.log("PARAMSSS", req.params.product_id)
   try {
      let result = await db.query(`SELECT * FROM product WHERE id=${req.params.product_id}`)
      console.log("THE DAMN THING", result[0].name)
      res.status(200).send(result[0])

   } catch (err) {
      console.log("AN ERROR", err);
   }
})

app.get('/products/:product_id/styles', async (req, res) => {

   try {
      let result1 = await db.query(`SELECT * FROM style WHERE productID=${req.params.product_id}`)
      let result2 = await db.query(`SELECT * FROM photo WHERE styleID=${req.params.product_id}`)

      if (result2.length > result1.length) {
         result2.length = result1.length;
      }

      let finalArr = [];
      for (let i = 0; i < result1.length; i++) {
         let finalObj = {};
         finalObj.product_id = req.params.product_id;
         result1[i].photos = [result2[i]];
         finalObj.results = result1;
         finalArr.push(finalObj)
      }

      res.status(200).send(finalArr);

   }
   catch (err) {
      console.log("AN ERROR", err);
      res.status(500).send(err);
   }
})

app.listen(port, () => {
   console.log(`The app server is running on port: ${port}`);
});



// // how to match style and photo? Nested async/await?
// app.get('/products/:product_id/styles', async (req, res) => {
//    // let stylesObj = {};
//    try {
//       let result = await db.query(`SELECT * FROM style WHERE productID=${req.params.product_id}`)
//       // console.log("RESULT FOR STYLES ENDPOINT", result[0].styleid)
//       res.status(200).send(result);
//    }
//    catch (err) {
//       console.log("AN ERROR", err);
//       res.status(500).send(err);
//    }
// })

// app.get('/photo/:productID', async (req, res) => {
//    try {
//       let result = await db.query(`SELECT * FROM photo WHERE styleID=${req.params.productID}`)
//       res.status(200).send(result);
//    } catch (err) {
//       console.log("AN ERROR", err);
//       res.status(500).send(err);
//    }
// })


   // potentially postgres aggragation (functionality in pg)
      // app.get('/photo/:product_id', async (req, res) => {
      // let result = await db.query(`SELECT ${req.params.product_id} from photo`)

      // stylesObj.photos = [];

      // result.map((element) => {
      //    let photoObj = {
      //       thumbnail_url: `${element.thumbnailURL}`,
      //       url: `${element.photoURL}`
      //    }
      //    stylesObj.photos.push(photoObj);
      // })

      // res.send(stylesObj); do I need this in a nested async/await?

// app.get("/product", async (req, res) => {
//    let result = await db.query("SELECT * from style limit 25")
//    let info = await function(result) => {
//      let result2 = db.query("select * from photo limit 25");
//      let obj = {
//         result: result,
//         result: result2
//      }
//      return obj;
//    }
//    let ultimateResult = info(result)
//    res.send(ultimateResult);
//  })
