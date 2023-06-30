const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require("../models/users")

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({
                message: `User with ${email} already exists`
            })
        } else {
            const hashedPassword = await bcrypt.hash(password, 8);
            let user = new User({
                name,
                email,
                password: hashedPassword,
            })
            user = await User.create(user);
            return res.json({
                message: 'User created successfully'
            })
        }
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})


authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'User with this email does not exist' })
        }
        const valid = await bcrypt.compare(password, user.password);
        if (!valid) {
            return res.json({ message: 'Incorrect Password' })
        }
        const token = jwt.sign({ id: user._id }, process.env.SECRET_KEY);
        res.json({
            token, ...user._doc
        })

    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})


module.exports = authRouter;