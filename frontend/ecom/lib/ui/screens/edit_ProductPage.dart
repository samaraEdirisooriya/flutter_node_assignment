import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/ui/layouts/product_form.dart';
import 'package:ecom/ui/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final product = Product(
      id: id,
      name: title,
      image: imageUrl,
      price: int.tryParse(price) ?? 0,
      quantity: 1,
    );

    return ProductFormPage(
      title: "Update Item",
      initialProduct: product,
      isEdit: true,
      onSubmit: (updatedProduct) {
        context.read<ProductBloc>().add(UpdateProduct(updatedProduct));
      },
    );
  }
}
