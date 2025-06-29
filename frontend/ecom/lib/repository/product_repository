import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductRepository {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://10.0.2.2:5000/api/products'),
    
    
  );


  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('/');
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print('Error fetching products: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch products: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete('/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to delete product: ${e.message}');
    }
  }

  Future<void> addProduct(Product p) async {
    try {
      await _dio.post('/', data: {
        'name': p.name,
        'price': p.price,
        'quantity': p.quantity,
        'image': p.image,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to add product: ${e.message}');
    }
  }

  Future<void> updateProduct(Product p) async {
    try {
      await _dio.put('/${p.id}', data: {
        'name': p.name,
        'price': p.price,
        'quantity': p.quantity,
        'image': p.image,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to update product: ${e.message}');
    }
  }
}
