// Import from package
import express, { Express } from "express";
import * as mongoose from "mongoose";
import * as dotenv from "dotenv";
dotenv.config();

// Immport from other files
import authRouter from "./routes/auth";
import path from "path";

// Init
const PORT = 3000;
const app: Express = express();
const CONNECTION_URL = process.env.CONNECTION_URL!;

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(express.static("../public"));

app.get("/hello", (req, res) => {
  res.status(200).send("Hello World");
});
// Connections
mongoose
  .connect(CONNECTION_URL)
  .then(() => console.log("Connected to Mongoose"))
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Listening to http://localhost:${PORT}`);
});