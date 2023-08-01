import { productSchema } from "./product.model";

const mongoose = require("mongoose");

const userScrema = mongoose.Schema(
  {
    name: {
      required: true,
      type: String,
      trim: true,
    },
    email: {
      required: true,
      type: String,
      trim: true,
      validate: {
        validator: (value: String) => {
          const regex =
            /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
          return value.match(regex);
        },
        message: "Please enter a valid email address",
      },
    },
    password: {
      required: true,
      type: String,
    },
    address: {
      type: String,
      default: "",
    },
    type: {
      type: String,
      default: "user",
    },
    // cart
    cart: [
      {
        product: productSchema,
        quantity: {
          type: Number,
          required: true,
        },
      },
    ],
  },
  { collection: "users" }
);

const User = mongoose.model("User", userScrema);

export { User, userScrema };
