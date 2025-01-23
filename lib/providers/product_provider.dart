import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Product> get products => _filteredProducts.isEmpty ? _products : _filteredProducts;

  // بيانات تجريبية للمنتجات
  final List<Product> _demoProducts = [
    Product(
      id: '1',
      name: 'تيشيرت قطني فاخر',
      description: 'تيشيرت قطني بجودة عالية، مريح ومناسب لجميع المناسبات',
      price: 299.99,
      salePrice: 199.99,
      imageUrl: 'https://m.media-amazon.com/images/I/7165rmCaTuL._AC_SY741_.jpg',
      category: 'ملابس',
      rating: 4.5,
      isOnSale: true,
      images: [
        'https://m.media-amazon.com/images/I/7165rmCaTuL._AC_SY741_.jpg',
        'https://m.media-amazon.com/images/I/7165rmCaTuL._AC_SY741_.jpg',
      ],
    ),
    Product(
      id: '2',
      name: 'سماعات بلوتوث لاسلكية',
      description: 'سماعات بجودة صوت عالية مع خاصية إلغاء الضوضاء',
      price: 599.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81Sh1mHyxvL._AC_SX466_.jpg',
      category: 'إلكترونيات',
      rating: 4.8,
      isOnSale: false,
      images: [
        'https://m.media-amazon.com/images/I/81Sh1mHyxvL._AC_SX466_.jpg',
        'https://m.media-amazon.com/images/I/81Sh1mHyxvL._AC_SX466_.jpg',
      ],
    ),
    Product(
      id: '3',
      name: 'ساعة ذكية',
      description: 'ساعة ذكية متعددة الوظائف مع تتبع اللياقة البدنية',
      price: 899.99,
      salePrice: 699.99,
      imageUrl: 'https://m.media-amazon.com/images/I/61wjDV8p6PL._AC_SL1500_.jpg',
      category: 'إكسسوارات',
      rating: 4.7,
      isOnSale: true,
      images: [
        'https://m.media-amazon.com/images/I/61wjDV8p6PL._AC_SL1500_.jpg',
        'https://m.media-amazon.com/images/I/61wjDV8p6PL._AC_SL1500_.jpg',
      ],
    ),
    Product(
      id: '4',
      name: 'حذاء رياضي',
      description: 'حذاء رياضي مريح مناسب للجري والتمارين الرياضية',
      price: 449.99,
      salePrice: 399.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81oYhO1GXqL._AC_SY575_.jpg',
      category: 'ملابس',
      rating: 4.3,
      isOnSale: true,
      images: [
        'https://m.media-amazon.com/images/I/81oYhO1GXqL._AC_SY575_.jpg',
        'https://m.media-amazon.com/images/I/81oYhO1GXqL._AC_SY575_.jpg',
      ],
    ),
    Product(
      id: '5',
      name: 'نظارة شمسية',
      description: 'نظارة شمسية أنيقة مع حماية من الأشعة فوق البنفسجية',
      price: 199.99,
      salePrice: 149.99,
      imageUrl: 'https://m.media-amazon.com/images/I/51b88vNJRSL._AC_SX679_.jpg',
      category: 'إكسسوارات',
      rating: 4.6,
      isOnSale: true,
      images: [
        'https://m.media-amazon.com/images/I/51b88vNJRSL._AC_SX679_.jpg',
        'https://m.media-amazon.com/images/I/51b88vNJRSL._AC_SX679_.jpg',
      ],
    ),
    Product(
      id: '6',
      name: 'لابتوب محمول',
      description: 'لابتوب خفيف الوزن مع أداء قوي وبطارية طويلة العمر',
      price: 3999.99,
      salePrice: 2999.99,
      imageUrl: 'https://m.media-amazon.com/images/I/815uX7wkOZS._AC_SL1500_.jpg',
      category: 'إلكترونيات',
      rating: 4.9,
      isOnSale: true,
      images: [
        'https://m.media-amazon.com/images/I/815uX7wkOZS._AC_SL1500_.jpg',
        'https://m.media-amazon.com/images/I/815uX7wkOZS._AC_SL1500_.jpg',
      ],
    ),
  ];

  // جلب المنتجات (محاكاة)
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // محاكاة تأخير الشبكة
      await Future.delayed(const Duration(seconds: 1));
      _products = _demoProducts;
      _filteredProducts = [];
    } catch (e) {
      _error = 'حدث خطأ أثناء تحميل المنتجات';
    }

    _isLoading = false;
    notifyListeners();
  }

  // البحث عن المنتجات
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
               product.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // الحصول على المنتجات حسب الفئة
  List<Product> getProductsByCategory(String category) {
    if (category == 'الكل') {
      return _products;
    }
    return _products.where((product) => product.category == category).toList();
  }
}
