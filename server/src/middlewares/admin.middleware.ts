import express, { NextFunction, Request, Response } from "express";
import jwt, { JwtPayload } from "jsonwebtoken";
import { User }  from "../models/users.model";

interface AuthRequest extends Request {
  userId?: string | JwtPayload;
  token?: string;
}

const admin = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const token = req.header("x-auth-token");
    console.log(token);
    if (!token)
      return res
        .status(401)
        .json({ message: "No auth token provided, access denied" });
    const verified = jwt.verify(token, process.env.SECRET_KEY!) as JwtPayload;
    if (!verified || typeof verified === "string")
      return res
        .status(401)
        .json({ message: "Token verification failed, authorization denied" });
    const user = await User.findById(verified.id);
    if (user.type === "user" || user.type === "seller") {
      return res.status(401).json({ message: "Your are not an admin" });
    }
    req.userId = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: (error as Error).message });
  }
};

export { admin, AuthRequest };
