import 'dart:convert';
import '../../../Data/data.dart';
import 'package:http/http.dart' as http;
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/url.dart';

class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final url = Uri.parse(Urls.readProduct);
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    );

    if (response.statusCode == 200) {
      print('Product list loading is successful');
      final data = jsonDecode(response.body);
      ProductModel productModel = ProductModel.fromJson(data);
      products = productModel.data ?? [];
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<void> fetchProductById(String sid) async {
    final url = Uri.parse(Urls.readProductById(sid));

    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    );

    if (response.statusCode == 200) {
      print('Product loaded Successfully');
      final data = jsonDecode(response.body);
      ProductModel productModel = ProductModel.fromJson(data);
      products = productModel.data ?? [];
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<bool> addProducts(
    String productName,
    int productCode,
    int unitPrice,
    int totalPrice,
    String image,
    int quantity,
  ) async {
    final url = Uri.parse(Urls.createProduct);
    print('add initiated');

    var response = await http.post(
      url,
      body: jsonEncode({
        'ProductName': productName,
        'ProductCode': productCode,
        'Img': image,
        'Qty': quantity,
        'UnitPrice': unitPrice,
        'TotalPrice': totalPrice,
      }),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    );
    print('response ${response.statusCode}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Successfully added product');
      return true;
    } else {
      print('Product add was unsuccessful');
      return false;
    }
  }

  Future<bool> updateProduct(
    String sid,
    String productName,
    int productCode,
    int unitPrice,
    int totalPrice,
    String image,
    int quantity,
  ) async {
    final url = Uri.parse(Urls.updateProduct(sid));
    print('update initiated');
    var response = await http.post(
      url,
      body: jsonEncode({
        'ProductName': productName,
        'ProductCode': productCode,
        'Img': image,
        'Qty': quantity,
        'UnitPrice': unitPrice,
        'TotalPrice': totalPrice,
      }),
      headers: {
        'Accept': 'application/json',
        'Accept-Language': 'en-US,en;q=0.9',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Product edition was successful');
      return true;
    }
    throw Exception("Failed to edit product info");
  }

  Future<void> delectProduct(String sId) async {
    final url = Uri.parse(Urls.deleteProductById(sId));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Deleted product successfully');
    } else {
      print('Failed to delete the product');
    }
  }
}
