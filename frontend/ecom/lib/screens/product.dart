import 'package:ecom/blocks/Product/product_bloc.dart';
import 'package:ecom/screens/edit_ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final int id;

  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.id,
  });
bool isValidUrl(String url) {
  return url.startsWith('http://') || url.startsWith('https://');
}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                    color: theme.colorScheme.primary),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
              child: Hero(
                tag: name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    isValidUrl(image) ? image : 'https://th.bing.com/th/id/OIP.NN08Yy_-cXhw2B0f8DBgDwHaHa?o=7&pid=ImgDetMain',
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                 onPressed: () {
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProductPage(
              title: name,
              imageUrl: image,
              price: price,
              id: 5, // You can replace this with the actual product ID // Default quantity or pass as needed
            )),
          );
  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text("Edit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Confirm and delete
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Delete"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
