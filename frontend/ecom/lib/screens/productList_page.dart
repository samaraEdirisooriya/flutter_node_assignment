import 'package:ecom/blocks/auth_/auth_bloc.dart';
import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/ui/screens/auth/login_page.dart';
import 'package:ecom/ui/screens/product_page.dart';
import 'package:ecom/ui/screens/add_item.dart';
import 'package:ecom/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(LoadProducts());
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductError) {
              return ListView(
                children: [
                  const SizedBox(height: 200),
                  Center(child: Text(state.message)),
                ],
              );
            }

            if (state is ProductLoaded) {
              final products = state.products;

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    elevation: 2,
                    pinned: true,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutRequested());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                      ),
                    ],
                    expandedHeight: 100,
                    backgroundColor: theme.appBarTheme.backgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Ecoom',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  if (products.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No products available',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    )
                  else
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
                                        id: product.id,
                                      ),
                                ),
                              );
                            },
                            child: ProductCard(
                              title: product.name,
                              price: product.price.toString(),
                              imageUrl: product.image,
                              id: product.id,
                              onDelete: () {
                                context.read<ProductBloc>().add(
                                  DeleteProduct(product.id),
                                );
                              },
                              onUpgade: () {},
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
