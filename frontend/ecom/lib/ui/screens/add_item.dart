import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/ui/layouts/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductFormPage(
      title: "Add New Item",
      isEdit: false,
      onSubmit: (product) {
        context.read<ProductBloc>().add(AddProduct(product));
      },
    );
  }
}
