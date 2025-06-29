import 'package:ecom/blocks/Product/product_bloc.dart';
import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;

  bool _isSubmitting = false;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _imageController = TextEditingController(text: widget.product.image);
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()).toInt(),
        quantity: widget.product.quantity,
        image: _imageController.text.trim(),
      );

      setState(() => _isSubmitting = true);
      context.read<ProductBloc>().add(UpdateProduct(updatedProduct));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product"), centerTitle: true),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoaded && _isSubmitting) {
            setState(() => _isSubmitting = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product updated successfully!')),
            );
            Navigator.pop(context);
          } else if (state is ProductError && _isSubmitting) {
            setState(() => _isSubmitting = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    prefixIcon: Icon(Icons.label_outline),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Enter product name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.price_change_outlined),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Enter price' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    prefixIcon: Icon(Icons.image_outlined),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Enter image URL' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _submitForm,
                  icon: const Icon(Icons.update),
                  label: Text(_isSubmitting ? 'Updating...' : 'Update Product'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
