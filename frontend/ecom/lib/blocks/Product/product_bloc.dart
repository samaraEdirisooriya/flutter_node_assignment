import 'package:bloc/bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/repository/product_repository';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products'));
      }
    });

    on<DeleteProduct>((event, emit) async {
      await repository.deleteProduct(event.id);
      add(LoadProducts());
    });
  }
}
