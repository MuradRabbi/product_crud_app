import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model_class/product_model.dart';


const String baseUrl = "http://35.73.30.144:2008/api/v1";

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/ReadProduct"));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic> && decoded.containsKey("data")) {
        List<dynamic> data = decoded["data"];
        return data.map((e) => Product.fromJson(e)).toList();
      }

      if (decoded is List) {
        return decoded.map((e) => Product.fromJson(e)).toList();
      }

      throw Exception("Unexpected response format");
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<void> createProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse("$baseUrl/CreateProduct"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to create product");
    }
  }

  static Future<void> updateProduct(String id, Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse("$baseUrl/UpdateProduct/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update product");
    }
  }

  static Future<void> deleteProduct(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/DeleteProduct/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}

