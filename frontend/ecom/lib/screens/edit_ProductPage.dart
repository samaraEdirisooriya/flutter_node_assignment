import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.id,
  });

  final String title;
  final String imageUrl;
  final String price;
  final int id;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
    final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
   bool _isSubmitting = false;
   void _submitForm() {
  if (_formKey.currentState!.validate()) {
    final name = _nameController.text.trim();
    final priceText = _priceController.text.trim();
    final image = _imageUrlController.text.trim();

    double? price = double.tryParse(priceText);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid price')),
      );
      return;
    }

    final updatedProduct = Product(
      id: widget.id, // Use existing product id for update
      name: name,
      quantity: 1,
      price: price.toInt(),// Keep existing quantity or modify if needed
      image: image,
    );

    setState(() => _isSubmitting = true);

    // Dispatch update product event instead of add
    context.read<ProductBloc>().add(UpdateProduct(updatedProduct));
  }
}
 @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Update Item"), centerTitle: true),
      resizeToAvoidBottomInset: true, // Ensures keyboard pushes content up
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError && _isSubmitting) {
            setState(() => _isSubmitting = false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
          if (state is ProductLoaded && _isSubmitting) {
            setState(() => _isSubmitting = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product Updated successfully!')),
            );
            Navigator.pop(context); // Go back to product list
          }
        },
        child: SingleChildScrollView(
          // <-- Wraps the form
          padding: const EdgeInsets.all(24).add(
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          ), // Adds padding for keyboard
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
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter product name'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price (e.g. 3500)',
                    prefixIcon: Icon(Icons.price_change_outlined),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter product price'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    prefixIcon: Icon(Icons.image_outlined),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter image URL'
                              : null,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _submitForm,
                    icon:
                        _isSubmitting
                            ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Icon(Icons.save),
                    label: Text(_isSubmitting ? "Updating..." : "Update Product"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
