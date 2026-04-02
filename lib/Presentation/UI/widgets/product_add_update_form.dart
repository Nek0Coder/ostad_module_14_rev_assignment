import 'package:flutter/material.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/extension_utils.dart';
// import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';
// import 'package:ostad_module_14_rev_assignment/Data/data.dart';
import '../../../Controllers/product_controller.dart';

final ProductController productController = ProductController();
Future<void> addProduct(
  String productName,
  String productCode,
  String productImage,
  String productQuantity,
  String productUnitPrice,
) async {
  try {
    int totalPrice = int.parse(productUnitPrice) * int.parse(productQuantity);
    print(
      '$productName \n $productCode \n $productImage \n $productQuantity $productUnitPrice',
    );
    await productController.addProducts(
      productName,
      int.parse(productCode),
      int.parse(productUnitPrice),
      totalPrice,
      productImage,
      int.parse(productQuantity),
    );
    print('Tried2');
  } catch (e) {
    throw e.toString();
  }
}

Future<void> updateProduct(
  String sid,
  String productName,
  String productCode,
  String productImage,
  String productQuantity,
  String productUnitPrice,
) async {
  try {
    int totalPrice = int.parse(productUnitPrice) * int.parse(productQuantity);
    print(
      '$sid \n $productName \n $productCode \n $productImage \n $productQuantity $productUnitPrice',
    );

    await productController.updateProduct(
      sid,
      productName,
      int.parse(productCode),
      int.parse(productUnitPrice),
      totalPrice,
      productImage,
      int.parse(productQuantity),
    );
  } catch (e) {
    throw e.toString();
  }
  print('Inside update');
}

Future<dynamic> productForm(
  BuildContext context,
  double deviceHeight,
  double deviceWidth,
  String? sid,
  int? index,
  RegExp imageTypePattern,
  final formKey,
  final products,
  final refreshData,
) {
  TextEditingController productNameController = TextEditingController(
    text: (index != null) ? products[index].productName.toString() : '',
  );
  TextEditingController productCodeController = TextEditingController(
    text: (index != null) ? products[index].productCode.toString() : '',
  );
  TextEditingController productImageController = TextEditingController(
    text: (index != null) ? products[index].img.toString() : '',
  );
  TextEditingController productQuantityController = TextEditingController(
    text: (index != null) ? products[index].qty.toString() : '',
  );
  TextEditingController productUnitPriceController = TextEditingController(
    text: (index != null) ? products[index].unitPrice.toString() : '',
  );
  return showModalBottomSheet(
    elevation: 10,
    isDismissible: false,
    isScrollControlled: true,
    enableDrag: false,
    useSafeArea: true,
    context: context,

    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: .circular(30),
          color: Color.fromRGBO(34, 37, 45, 255),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: .min,
                // mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  20.hb,
                  Text(
                    (sid == null || sid.isEmpty)
                        ? "Add Product"
                        : "Update Product",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ).centered(),
                  10.hb,
                  Container(
                    height: 2,
                    width: deviceWidth * .90,
                    color: Colors.grey,
                  ),

                  20.hb,

                  TextFormField(
                    keyboardType: .name,
                    controller: productNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text(
                        "Product Name",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product Name cannot be empty";
                      }
                      return null;
                    },
                  ),

                  10.hb,

                  TextFormField(
                    keyboardType: .number,
                    controller: productCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text(
                        "Product Code",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product Code cannot be empty";
                      }
                      return null;
                    },
                  ),

                  10.hb,

                  TextFormField(
                    keyboardType: .url,
                    controller: productImageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text(
                        "Product Image Url",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product Image Url cannot be empty";
                      } else if (imageTypePattern.hasMatch(value) == false) {
                        return "Please provide a valid Image Url";
                      }
                      return null;
                    },
                  ),

                  10.hb,

                  TextFormField(
                    keyboardType: .number,
                    controller: productQuantityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text(
                        "Product Quantity",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product quantity cannot be empty";
                      }
                      return null;
                    },
                  ),

                  10.hb,

                  TextFormField(
                    keyboardType: .number,
                    controller: productUnitPriceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text(
                        "Product Unit Price",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Product unit price cannot be empty";
                      }
                      return null;
                    },
                  ),

                  15.hb,

                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (sid == null) {
                              await addProduct(
                                productNameController.text,
                                productCodeController.text,
                                productImageController.text,
                                productQuantityController.text,
                                productUnitPriceController.text,
                              );
                            } else {
                              await updateProduct(
                                sid,
                                productNameController.text,
                                productCodeController.text,
                                productImageController.text,
                                productQuantityController.text,
                                productUnitPriceController.text,
                              );
                            }
                            Navigator.pop(context);
                            refreshData();
                          }
                        },
                        child: SizedBox(
                          height: 30,
                          width: 100,
                          child: Text(
                            (sid == null) ? "Add Product" : "Update Product",
                            style: TextStyle(color: Colors.green),
                          ).centered(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 100,
                          height: 30,
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ).centered(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).withPadding(10),
          ),
        ),
      );
    },
  );
}
