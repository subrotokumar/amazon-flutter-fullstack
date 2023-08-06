import { Request, Response, NextFunction } from "express";
import jwt, { JwtPayload } from "jsonwebtoken";

interface AuthRequest extends Request {
  userId?: string | JwtPayload;
  token?: string;
}

const auth = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ message: "No auth token provided, access denied" });
    const verified = jwt.verify(token, process.env.SECRET_KEY!) as JwtPayload;
    if (!verified || typeof verified === "string")
      return res
        .status(401)
        .json({ message: "Token verification failed, authorization denied" });
    req.userId = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: (error as Error).message });
  }
};

export { auth, AuthRequest };
