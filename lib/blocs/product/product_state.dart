// product_state.dart
import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final List<String> selectedCategories;
  final String searchQuery;

  const ProductLoaded({
    required this.products,
    required this.filteredProducts,
    this.selectedCategories = const [],
    this.searchQuery = '',
  });

  ProductLoaded copyWith({
    List<Product>? products,
    List<Product>? filteredProducts,
    List<String>? selectedCategories,
    String? searchQuery,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [products, filteredProducts, selectedCategories, searchQuery];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
