const express = require('express');
const router = express.Router();
const { Product } = require('../models');

// GET all products
router.get('/', async (req, res) => {
  try {
    const products = await Product.findAll();
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch products' });
  }
});

// POST add product
router.post('/', async (req, res) => {
  const { name, price, quantity, image } = req.body;
  try {
    const newProduct = await Product.create({ name, price, quantity, image });
    res.status(201).json(newProduct);
  } catch (err) {
    res.status(400).json({ message: 'Failed to add product', error: err.message });
  }
});

// PUT update product
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, price, quantity, image } = req.body;
  try {
    const product = await Product.findByPk(id);
    if (!product) return res.status(404).json({ message: 'Product not found' });

    await product.update({ name, price, quantity, image });
    res.status(200).json(product);
  } catch (err) {
    res.status(500).json({ message: 'Failed to update product', error: err.message });
  }
});

// DELETE product
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const product = await Product.findByPk(id);
    if (!product) return res.status(404).json({ message: 'Product not found' });

    await product.destroy();
    res.status(204).send();
  } catch (err) {
    res.status(500).json({ message: 'Failed to delete product', error: err.message });
  }
});

module.exports = router;
