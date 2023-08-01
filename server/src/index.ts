// Import from package
import express, { Express } from "express";
import { connect as dbConnect } from "mongoose";
import { config } from "dotenv";

// Immport from other files
import authRouter from "./routes/auth.routes";
import adminRouter from "./routes/admin.routes";
import productRouter from "./routes/products.routes";
import userRouter from "./routes/user.routes";

// Init
config();
const PORT = Number(process.env.PORT) ?? 3000;
const app: Express = express();
const CONNECTION_URL = process.env.CONNECTION_URL!;

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

app.get("/hello", (_, res) => {
  res.status(200).send("Hello World");
});

// Mongo0se Connections
dbConnect(CONNECTION_URL)
  .then(() => console.log("Connected to Mongoose"))
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Listening to http://localhost:${PORT}`);
});
