// Import from package
console.clear()
const express = require('express')
const mongoose = require('mongoose')
require('dotenv').config()

// Immport from other files
const authRouter = require("./routes/auth");

// Init
const PORT = 3000
const app = express();
const CONNECTION_URL = process.env.CONNECTION_URL;

// Middleware
app.use(express.json());
app.use(express.static('public'))
app.use(authRouter);

// Connections
mongoose.connect(CONNECTION_URL).
    then(() => console.log('Connected to Mongoose'))
    .catch(e => console.log(e));

app.get("/", express.static('public'))

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Listening to http://localhost:${PORT}`)
})