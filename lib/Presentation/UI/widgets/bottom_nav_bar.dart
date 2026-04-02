import 'package:flutter/material.dart';

import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.inStock});

  final bool inStock;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .only(
        topLeft: Radius.circular(20),
        topRight: .circular(20),
      ),
      child: BottomAppBar(
        color: const Color.fromARGB(255, 241, 240, 240).withAlpha(80),
        // color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            InkWell(
              onTap: () => () {},
              child: Chip(
                backgroundColor: AppColors.buttonSplashColor,

                shape: StadiumBorder(),

                label: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    maxLines: 1,
                    textAlign: .center,
                    (inStock == false) ? "Preorder" : "Shop Now",

                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            (inStock == true)
                ? InkWell(
                    onTap: () => () {},
                    child: Chip(
                      backgroundColor: Colors.white,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.black,
                        ),
                      ),
                      shape: StadiumBorder(),

                      label: Text(
                        maxLines: 1,
                        textAlign: .center,

                        "Add To Chart",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
