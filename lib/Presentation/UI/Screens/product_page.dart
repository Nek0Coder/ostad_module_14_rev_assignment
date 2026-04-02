import 'package:flutter/material.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/widgets/product_storage_card.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/extension_utils.dart';
import '../widgets/product_color_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});
  final dynamic product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int productCount = 1;
  @override
  Widget build(BuildContext context) {
    bool inStock = false;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final product = widget.product;
    if (product.qty > 0) {
      inStock = true;
    } else {
      inStock = false;
    }

    void incrementQuantity() {
      if (productCount == product.qty) {
        return;
      }
      setState(() {
        productCount++;
      });
    }

    void decrementQuantity() {
      if (productCount == 1) {
        return;
      }
      setState(() {
        productCount--;
      });
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.scaffoldColor,

      bottomNavigationBar: BottomNavBar(inStock: inStock),

      appBar: appBar(() {
        setState(() {
          if (AppColors.scaffoldColor == Colors.black) {
            AppColors.scaffoldColor = Colors.white;
            AppColors.productCardShadowColor = const Color.fromARGB(
              255,
              230,
              229,
              229,
            );
          } else {
            AppColors.scaffoldColor = Colors.black;
            AppColors.productCardShadowColor = Color.fromARGB(
              160,
              210,
              198,
              198,
            );
          }
        });
      }),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: .all(0),
              child: Container(
                padding: .only(left: 5, right: 5),

                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      height: deviceHeight * .4,
                      width: deviceWidth * .95,
                      decoration: BoxDecoration(
                        color: AppColors.productCardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(69, 0, 0, 0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 10,
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
                    ).centered().withPadding(10),

                    Container(
                      // width: deviceWidth,
                      padding: .all(10),
                      decoration: BoxDecoration(
                        color: AppColors.productCardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(69, 0, 0, 0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .start,
                        children: [
                          10.hb,
                          Text(
                            product.productName.toString(),
                            maxLines: 2,
                            style: TextStyle(
                              overflow: .ellipsis,
                              color: Colors.black,
                              fontWeight: .w600,
                              fontSize: 22,
                            ),
                          ),

                          10.hb,

                          Wrap(
                            children: [
                              styledText(context, .left, [
                                textSpan(
                                  '৳ ${product.unitPrice}',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: .w500,
                                ),
                                textSpan(
                                  '  (Cash Price)',
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: .w500,
                                ),
                              ]),

                              10.wb,

                              Text(
                                '৳ ${((product.unitPrice == null || product.unitPrice == 0) ? 0 : (product.unitPrice! + product.unitPrice! / 2).toInt()).toString()}',
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey,
                                  color: Colors.grey,
                                  fontWeight: .w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          10.hb,

                          Wrap(
                            children: [
                              styledText(context, .left, [
                                textSpan(
                                  'Availability: ',
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: .w500,
                                ),
                                textSpan(
                                  (product.qty > 0)
                                      ? "In Stock (${product.qty})"
                                      : "Stock Out",
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ]),

                              10.wb,

                              Text(
                                "|",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),

                              10.wb,

                              styledText(context, .left, [
                                textSpan(
                                  'Code: ',
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: .w500,
                                ),
                                textSpan(
                                  product.productCode.toString(),
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ]),
                            ],
                          ),
                          15.hb,

                          ProductColorCard(deviceWidth: deviceWidth).centered(),

                          15.hb,

                          ProductStorageCard(
                            deviceWidth: deviceWidth,
                          ).centered(),

                          15.hb,

                          Text(
                            'Select Quantity:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: .w500,
                            ),
                          ),

                          15.hb,

                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 219, 222, 224),
                              borderRadius: .all(Radius.circular(30)),
                            ),
                            child: Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    decrementQuantity();
                                  },
                                  icon: Icon(Icons.remove, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    productCount.toString(),
                                    maxLines: 1,
                                    textAlign: .center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    incrementQuantity();
                                  },
                                  icon: Icon(Icons.add, color: Colors.black),
                                ),
                              ],
                            ).centered().withPadding(10),
                          ),
                        ],
                      ),
                    ).withPadding(10).centered(),

                    100.hb,
                  ],
                ),
              ),
            ),
          ],
        ).centered(),
      ),
    );
  }
}
