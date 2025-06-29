const { User } = require("../models");

exports.register = async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const existing = await User.findOne({ where: { email } });
    if (existing)
      return res.status(400).json({ message: "User already exists" });

    await User.create({ name, email, password });
    res.status(201).json({ message: "User registered" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res
        .status(400)
        .json({ message: "Email and password are required" });
    }

    const user = await User.findOne({ where: { email } });

    if (!user) {
      return res.status(401).json({ message: "User not found" });
    }

    if (user.password !== password) {
      return res.status(401).json({ message: "Incorrect password" });
    }

    res.status(200).json({ message: "Login successful" });
  } catch (err) {
    console.error("Login Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};
