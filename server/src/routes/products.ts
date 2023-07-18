import express from "express";
import { auth } from "../middlewares/auth";
import { Product } from "../models/product";
const productRouter = express.Router();

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({
      category: req.query.category,
    });
    return res.json(products);
  } catch (err) {
    res.status(500).json({ error: (err as Error).message });
  }
});

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: {
        $regex: req.query.name,
        $options: "i",
      },
    });
    return res.json(products);
  } catch (err) {
    res.status(500).json({ error: (err as Error).message });
  }
});

export default productRouter;
