import { Router, Request, Response } from "express";
import { admin } from "../middlewares/admin.middleware";
import { Product } from "../models/product.model";
const adminRouter = Router();

// Add product
adminRouter.post(
  "/admin/add-product",
  admin,
  async (req: Request, res: Response) => {
    try {
      const { name, description, images, quantity, price, category } = req.body;
      let product = new Product({
        name,
        description,
        images,
        quantity,
        price,
        category,
      });
      product = await product.save();
      res.json(product);
    } catch (err) {
      res.status(500).json({ error: (err as Error).message });
    }
  }
);

// Get all products
adminRouter.get(
  "/admin/products",
  admin,
  async (req: Request, res: Response) => {
    try {
      let products = await Product.find({});
      res.json(products);
    } catch (err) {
      res.status(500).json({ error: (err as Error).message });
    }
  }
);

// Delete products by Id
adminRouter.post(
  "/admin/delete-product",
  admin,
  async (req: Request, res: Response) => {
    try {
      const { id } = req.body;
      let product = await Product.findByIdAndDelete(id);
      res.json(product);
    } catch (err) {
      res.status(500).json({ error: (err as Error).message });
    }
  }
);

export default adminRouter;
