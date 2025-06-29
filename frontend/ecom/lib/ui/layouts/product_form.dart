import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/ui/widgets/text_fild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({
    super.key,
    required this.title,
    this.initialProduct,
    required this.onSubmit,
    required this.isEdit,
  });

  final String title;
  final Product? initialProduct;
  final bool isEdit;
  final void Function(Product product) onSubmit;

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialProduct != null) {
      _nameController.text = widget.initialProduct!.name;
      _priceController.text = widget.initialProduct!.price.toString();
      _imageUrlController.text = widget.initialProduct!.image;
    }
  }

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

      final product = Product(
        id: widget.initialProduct?.id ?? 0,
        name: name,
        quantity: 1,
        price: price.toInt(),
        image: image,
      );

      setState(() => _isSubmitting = true);
      widget.onSubmit(product);
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
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
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
              SnackBar(
                content: Text(
                  widget.isEdit
                      ? 'Product updated successfully!'
                      : 'Product added successfully!',
                ),
              ),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24).add(
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInputField(
                  controller: _nameController,
                  label: 'Product Name',
                  icon: Icons.label_outline,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter product name'
                              : null,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _priceController,
                  label: 'Price (e.g. 3500)',
                  icon: Icons.price_change_outlined,
                  keyboardType: TextInputType.number,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter product price'
                              : null,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: _imageUrlController,
                  label: 'Image URL',
                  icon: Icons.image_outlined,
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
                    label: Text(
                      _isSubmitting
                          ? widget.isEdit
                              ? "Updating..."
                              : "Adding..."
                          : widget.isEdit
                          ? "Update Product"
                          : "Add Product",
                    ),
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
