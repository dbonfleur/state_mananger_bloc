import '../models/product_model.dart';

class ProductRepository {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Maçã',
      description: 'Maçãs vermelhas e suculentas',
      price: 1.5,
      imageUrl: 'assets/images/maca.png',
    ),
    Product(
      id: '2',
      name: 'Banana',
      description: 'Bananas maduras',
      price: 1.0,
      imageUrl: 'assets/images/banana.webp',
    ),
    Product(
      id: '3',
      name: 'Laranjas',
      description: 'Laranjas frescas',
      price: 2.0,
      imageUrl: 'assets/images/laranja.webp',
    ),
  ];

  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return _products;
  }
}
