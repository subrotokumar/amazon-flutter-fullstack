import { Router, Request, Response } from "express";
import bcrypt from "bcryptjs";
import * as jwt from "jsonwebtoken";
import { auth, AuthRequest } from "../middlewares/auth.middleware";
import { User, userScrema } from "../models/users.model";

const authRouter = Router();

/**
 * Get Request
 */
authRouter.post("/auth/signup", async (req: Request, res: Response) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({
        message: `User with ${email} already exists`,
      });
    } else {
      const hashedPassword = await bcrypt.hash(password, 8);
      let user = new User({
        name,
        email,
        password: hashedPassword,
      });
      user = await User.create(user);
      return res.json({
        message: "User created successfully",
      });
    }
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post("/auth/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ message: "User with this email does not exist" });
    }
    const valid = await bcrypt.compare(password, user.password);
    if (!valid) {
      return res.status(400).json({ message: "Incorrect Password" });
    }
    const token = jwt.sign({ id: user._id }, process.env.SECRET_KEY!);
    return res.json({
      token,
      ...user._doc,
    });
  } catch (err) {
    if (typeof err === "string") {
      return res.status(500).json({ error: err });
    } else if (err instanceof Error) {
      return res.status(500).json({ error: err.message });
    }
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, process.env.SECRET_KEY!);
    if (!verified || typeof verified === "string") return res.json(false);
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (error) {
    res.status(500).json({ error: (error as Error).message });
  }
});

// Get User Data
authRouter.get("/", auth, async (req: AuthRequest, res) => {
  try {
    const user = await User.findById({ _id: req.userId });
    console.log(user);
    res.status(200).json({ ...user._doc, token: req.token });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

export default authRouter;
