const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const { sequelize } = require("./models");

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());

const authRoutes = require("./routes/authRoutes");
const productRoutes = require("./routes/products");

app.use("/api/auth", authRoutes);
app.use("/api/products", productRoutes);

app.get("/", (req, res) => res.send("API is running"));

sequelize.sync().then(() => {
  app.listen(PORT, () =>
    console.log(`Server running at http://localhost:${PORT}`)
  );
});
