import 'package:bloc/bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/repository/Product_repository.dart';
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
        emit(ProductError(e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) async {
      try {
        await repository.deleteProduct(event.id);
        add(LoadProducts());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      try {
        await repository.addProduct(event.product);
        add(LoadProducts());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<UpdateProduct>((event, emit) async {
      try {
        await repository.updateProduct(event.product);
        add(LoadProducts()); 
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
