// Import from package
import express, { Express } from "express";
import * as mongoose from "mongoose";
import * as dotenv from "dotenv";
dotenv.config();

// Immport from other files
import authRouter from "./routes/auth";

// Init
const PORT = 3000;
const app: Express = express();
const CONNECTION_URL = process.env.CONNECTION_URL!;

// Middleware
app.use(express.json());
app.use(express.static("public"));
app.use(authRouter);

// Connections
mongoose
  .connect(CONNECTION_URL)
  .then(() => console.log("Connected to Mongoose"))
  .catch((e) => console.log(e));

app.get("/", express.static("public"));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Listening to http://localhost:${PORT}`);
});
