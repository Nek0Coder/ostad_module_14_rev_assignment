import 'package:flutter/material.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/Screens/product_page.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/extension_utils.dart';
import 'package:ostad_module_14_rev_assignment/Data/data.dart';
import '../widgets/product_add_update_form.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productList,
    required this.index,
    required this.formKey,
    required this.refreshData,
  });
  final int index;
  final List<Data> productList;
  final dynamic formKey;
  final Function refreshData;

  @override
  Widget build(BuildContext context) {
    final product = productList[index];
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    dynamic viewBottomSheet(String? sid, final products, int index) {
      final imageTypePattern = RegExp(
        r'\.(jpg|jpeg|png|webp|gif)$',
        caseSensitive: false,
      );
      return productForm(
        context,
        deviceHeight,
        deviceWidth,
        sid,
        index,
        imageTypePattern,
        formKey,
        products,
        refreshData,
      );
    }

    Future<void> deleteProduct(String sid) async {
      try {
        print('$sid ');
        await productController.delectProduct(sid);
      } catch (e) {
        throw e.toString();
      }
      print('Inside delete');
    }

    return Dismissible(
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(69, 0, 0, 0)),
        ),
        child: Icon(Icons.delete, color: Colors.white, size: 40).centered(),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await deleteProduct(product.sId ?? '');
        refreshData();
      },

      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
        child: Container(
          padding: .only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: AppColors.productCardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(69, 0, 0, 0)),
            boxShadow: [
              BoxShadow(
                color: AppColors.productCardShadowColor,
                blurRadius: .5,
                spreadRadius: .5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double availableHeight = constraints.maxHeight;
              final double availableWidth = constraints.maxWidth;
              return Column(
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: availableHeight * .02,
                      left: availableWidth * .02,
                      right: availableWidth * .02,
                      bottom: availableHeight * .02,
                    ),

                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        '${product.img}',
                        fit: .contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/failed_to_load_image.jpg',
                            fit: BoxFit.contain, // Keep it consistent
                          );
                        },

                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),

                  Text(
                    product.productName.toString(),
                    maxLines: 2,
                    style: TextStyle(
                      overflow: .ellipsis,
                      color: Colors.black,
                      fontWeight: .w500,
                      fontSize: 19,
                    ),
                  ),

                  Spacer(),
                  Text(
                    '৳ ${product.unitPrice}',
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: .w500,
                      fontSize: 19,
                    ),
                  ),
                  5.hb,

                  Wrap(
                    children: [
                      Text(
                        '৳ ${((product.unitPrice == null || product.unitPrice == 0) ? 0 : (product.unitPrice! + product.unitPrice! / 2).toInt()).toString()}',
                        maxLines: 1,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                          color: Colors.grey,
                          fontWeight: .w500,
                          fontSize: availableWidth * .08,
                        ),
                      ),

                      (availableWidth * .04).wb,

                      Container(
                        width: availableWidth * .5,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(220, 252, 231, 222),
                          borderRadius: .circular(15),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 4,
                            right: 4,
                            top: 3,
                            bottom: 3,
                          ),

                          child: Text(
                            maxLines: 1,
                            textAlign: .center,

                            "৳`${(product.unitPrice! / 2).toInt()} OFF",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: .w500,
                              fontSize: availableWidth * .07,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          overlayColor: AppColors.buttonSplashColor,
                        ),

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(product: product),
                            ),
                          );
                        },

                        onHover: (value) => {
                          // AppColors.buttonSplashColor = Colors.orange,
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: availableWidth * .01,
                            right: availableWidth * .01,
                          ),

                          child: Text(
                            "Shop now",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          viewBottomSheet(product.sId, productList, index);
                        },
                        icon: Icon(Icons.edit, color: Colors.grey),
                      ),
                    ],
                  ),

                  (availableHeight * .02).hb,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
