part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class DeleteProduct extends ProductEvent {
  final int id;
  DeleteProduct(this.id);
}

class AddProduct extends ProductEvent {
  final Product product;
  AddProduct(this.product);
}
