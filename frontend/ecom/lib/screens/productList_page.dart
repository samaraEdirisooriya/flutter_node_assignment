import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/screens/product.dart';
import 'package:ecom/screens/add_item.dart';
import 'package:ecom/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is ProductError) return Center(child: Text(state.message));
          if (state is ProductLoaded) {
            final products = state.products;
            return CustomScrollView(
              slivers: [
                
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductDetailsPage(
                                    name: product.name,
                                    price: product.price.toString(),
                                    image: product.image,
                                  ),
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product.name,
                          price: product.price.toString(),
                          imageUrl: product.image,
                        ),
                      );
                    }, childCount: products.length),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
     floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemPage(),
                        ),
                      );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
