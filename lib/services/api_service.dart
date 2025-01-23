import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'YOUR_API_BASE_URL';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search?q=$query'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception('Failed to search products');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<User> getUserProfile(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load user profile');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
