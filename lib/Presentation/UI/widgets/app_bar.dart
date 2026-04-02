import 'package:flutter/material.dart';

import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/extension_utils.dart';

dynamic appBar(VoidCallback onToggle) => AppBar(
  backgroundColor: Colors.black,

  toolbarHeight: 80,
  title: Column(
    children: [
      Container(
        alignment: .centerLeft,
        height: kToolbarHeight * .5,
        child: Row(
          children: [
            Image.network(
              'https://www.applegadgetsbd.com/_next/image?url=https%3A%2F%2Fadminapi.applegadgetsbd.com%2Fstorage%2Fmedia%2Flarge%2Flogo-3717.png&w=1920&q=100',
              fit: .contain,
            ),
            Spacer(),
            IconButton(
              onPressed: onToggle,
              icon: (AppColors.scaffoldColor == Colors.black)
                  ? Icon(
                      Icons.light_mode_outlined,
                      color: const Color.fromARGB(255, 235, 162, 52),
                      size: 25,
                    )
                  : Icon(
                      Icons.dark_mode_outlined,
                      color: const Color.fromARGB(255, 71, 36, 130),
                      size: 25,
                    ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      10.hb,
      Container(
        height: 35,

        decoration: BoxDecoration(
          borderRadius: .all(Radius.circular(15)),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              border: .none,
              hintText: "Search 🔍︎",
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.buttonSplashColor,
                  padding: .only(left: 15, right: 15),
                ),
                onPressed: () {},
                icon: Icon(Icons.search, color: Colors.white),
              ).withPadding(2),
            ),

            style: TextStyle(color: Colors.white),
          ),
        ).centered(),
      ),
      15.hb,
    ],
  ),

  // actions: [
  //   IconButton(
  //     onPressed: onToggle,
  //     icon: (AppColors.scaffoldColor == Colors.black)
  //         ? Icon(Icons.toggle_off, color: Colors.white)
  //         : Icon(Icons.toggle_on, color: Colors.orange),
  //   ),
  //   IconButton(
  //     onPressed: () {},
  //     icon: Icon(Icons.shopping_cart, color: Colors.deepOrange),
  //   ),
  // ],
);
