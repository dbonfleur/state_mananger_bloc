// product_bloc.dart
import 'package:bloc/bloc.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateSearchQuery>(_onUpdateSearchQuery);
    on<ToggleCategory>(_onToggleCategory);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(
        products: products,
        filteredProducts: products,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onUpdateSearchQuery(UpdateSearchQuery event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(currentState.copyWith(searchQuery: event.query));
    }
  }

  void _onToggleCategory(ToggleCategory event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final selectedCategories = List<String>.from(currentState.selectedCategories);
      if (selectedCategories.contains(event.category)) {
        selectedCategories.remove(event.category);
      } else {
        selectedCategories.add(event.category);
      }
      emit(currentState.copyWith(selectedCategories: selectedCategories));
    }
  }
}
