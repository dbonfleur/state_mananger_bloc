import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class ToggleSortByName extends ProductEvent {}

class ToggleSortByPrice extends ProductEvent {}

class UpdateSearchQuery extends ProductEvent {
  final String query;

  const UpdateSearchQuery(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleCategory extends ProductEvent {
  final String category;

  const ToggleCategory(this.category);

  @override
  List<Object> get props => [category];
}
