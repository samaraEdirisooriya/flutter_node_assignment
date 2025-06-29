import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/ui/screens/edit_ProductPage.dart';
import 'package:ecom/ui/screens/ecom_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: theme.colorScheme.primary,
                ),
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
                    isValidUrl(image) ? image : dotenv.env['BaseUrl_Img']!,
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
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
                      MaterialPageRoute(
                        builder:
                            (context) => EditProductPage(
                              title: name,
                              imageUrl: image,
                              price: price,
                              id: id,
                            ),
                      ),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    context.read<ProductBloc>().add(DeleteProduct(id));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const EcomApp()),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Delete"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
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
