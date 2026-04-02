import 'package:flutter/material.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/extension_utils.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';
import 'package:ostad_module_14_rev_assignment/Data/data.dart';
import '../widgets/app_bar.dart';
import '../../../Controllers/product_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/product_add_update_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> arr = [
    "Samsung Galaxy S20 Ultra",
    "Iphone 15 Max",
    "Motorola Edge 60 Fusion 5G",
    "CMF by Nothing Phone 2 Pro Max",
  ];

  final ProductController _productController = ProductController();
  List<Data> products = [];
  bool isLoading = true;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initialLoad();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initialLoad() async {
    try {
      await _productController.fetchProducts();
      final data = _productController.products;
      setState(() {
        products = data;
        isLoading = false;
        print('Length ${products.length}');
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> refreshData() async {
    await _productController.fetchProducts();
    final newData = _productController.products;
    setState(() {
      products = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    dynamic viewBottomSheet(String? sid, final products) {
      final imageTypePattern = RegExp(
        r'\.(jpg|jpeg|png|webp|gif)$',
        caseSensitive: false,
      );
      return productForm(
        context,
        deviceHeight,
        deviceWidth,
        sid,
        null,
        imageTypePattern,
        _formKey,
        products,
        refreshData,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          viewBottomSheet(null, _productController.products);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
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

      body: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          10.hb,
          Expanded(
            child: RefreshIndicator(
              child: (isLoading)
                  ? Column(
                      mainAxisAlignment: .center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(
                          "Loading",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : (errorMessage == null)
                  ? GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: products.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.50,
                        crossAxisCount: (deviceWidth >= 600) ? 4 : 2,
                        // mainAxisSpacing: 15,
                        // crossAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        index: index,
                        productList: products,
                        refreshData: refreshData,
                        formKey: _formKey,
                      ), ////////////////////
                    )
                  : Column(
                      children: [
                        Text(
                          "$errorMessage",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),

              onRefresh: () {
                setState(() {});
                return refreshData();
              },
            ),
          ),
        ],
      ),
    ); //
  }
}
