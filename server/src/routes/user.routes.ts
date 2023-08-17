import { Router } from "express";
import { AuthRequest, auth } from "../middlewares/auth.middleware";
import { Product } from "../models/product.model";
import { User } from "../models/users.model";

const userRouter = Router();

userRouter.post(
  "/api/user/add-to-cart",
  auth,
  async (req: AuthRequest, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findOne({ _id: id });
      let user = await User.findOne({ _id: req.userId });
      if (user.cart.length == 0) {
        user.cart.push({ product, quantity: 1 });
      } else {
        for (let i = 0; i < user.cart.length; i++) {
          if (user.cart[i].product._id.toString() === product?._id.toString()) {
            user.cart[i].quantity++;
            break;
          }
        }
      }
      user = await user.save();
      res.json(user);
    } catch (err) {
      res.status(500).json({
        error: (err as Error).message,
      });
    }
  }
);

userRouter.post(
  "/api/user/decrease-from-cart",
  auth,
  async (req: AuthRequest, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findOne({ _id: id });
      let user = await User.findOne({ _id: req.userId });
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.toString() === product?._id.toString()) {
          if (user.cart[i].quantity > 1) {
            user.cart[i].quantity--;
          } else {
            user.cart[i].splice(i, 1);
          }
          user = await user.save();
          break;
        }
      }
      res.json(user);
    } catch (err) {
      res.status(500).json({
        error: (err as Error).message,
      });
    }
  }
);

export default userRouter;
