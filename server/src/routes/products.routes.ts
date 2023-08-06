import { Router } from "express";
import { auth } from "../middlewares/auth.middleware";
import { Product } from "../models/product.model";
const productRouter = Router();

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
        $regex: req.params.name,
        $options: "i",
      },
    });
    return res.json(products);
  } catch (err) {
    res.status(500).json({ error: (err as Error).message });
  }
});

// Post request route to rate the product
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;

    let product = await Product.findById(id);
    for (let i = 0; i < product!.ratings.length; i++) {
      if (product?.ratings[i].userId == id) {
        product?.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: id,
      rating,
    };

    product!.ratings.push(ratingSchema);

    product = await product!.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({
      error: (e as Error).message,
    });
  }
});

productRouter.get("/api/producct/deal-of-the-day", async (req, res) => {
  try {
    let product = await Product.find({});
    product.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;
      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }
      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }
      return bSum - aSum;
    });
    res.json(product[0]);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

export default productRouter;
