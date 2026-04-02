import 'package:flutter/material.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/app_colors.dart';
import 'package:ostad_module_14_rev_assignment/Presentation/UI/utils/extension_utils.dart';

class ProductStorageCard extends StatefulWidget {
  const ProductStorageCard({super.key, required this.deviceWidth});

  final double deviceWidth;

  @override
  State<ProductStorageCard> createState() => ProductStorageCardState();
}

class ProductStorageCardState extends State<ProductStorageCard> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    Color chipBorderColor = AppColors.chipBorderColor;
    return Container(
      width: widget.deviceWidth * .9,
      padding: .all(20),
      decoration: BoxDecoration(
        color: AppColors.productCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(69, 0, 0, 0)),
      ),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,

        children: [
          Text(
            'Storage',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: .w500,
            ),
          ),
          Wrap(
            children: [
              ChoiceChip(
                backgroundColor: AppColors.productCardColor,
                selectedColor: AppColors.productCardColor,
                selectedShadowColor: AppColors.buttonSplashColor,

                selected: isSelected,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() {
                    isSelected = value;
                  });
                },

                // avatarBorder: ,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: isSelected
                        ? const Color.fromRGBO(242, 127, 32, 255)
                        // ignore: dead_code
                        : AppColors.chipBorderColor,
                    width: 2,
                  ),
                ),

                label: Text(
                  maxLines: 1,
                  textAlign: .center,

                  "1TB",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: .w500,
                    fontSize: 15,
                  ),
                ),
              ),

              10.wb,

              ChoiceChip(
                backgroundColor: AppColors.productCardColor,
                selectedColor: AppColors.productCardColor,
                selectedShadowColor: AppColors.buttonSplashColor,

                selected: false,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() {
                    isSelected = value;
                    chipBorderColor = const Color.fromARGB(255, 225, 220, 220);
                  });
                },
                shape: StadiumBorder(side: BorderSide(color: chipBorderColor)),

                label: Text(
                  maxLines: 1,
                  textAlign: .center,

                  "256GB",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: .w500,
                    fontSize: 15,
                  ),
                ),
              ),
              10.wb,
              ChoiceChip(
                backgroundColor: AppColors.productCardColor,
                selectedColor: AppColors.productCardColor,
                selectedShadowColor: AppColors.buttonSplashColor,

                selected: false,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() {
                    chipBorderColor = const Color.fromARGB(255, 225, 220, 220);
                  });
                },
                shape: StadiumBorder(side: BorderSide(color: chipBorderColor)),

                label: Text(
                  maxLines: 1,
                  textAlign: .center,

                  "512GB",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: .w500,
                    fontSize: 15,
                  ),
                ),
              ),
              10.wb,
            ],
          ),
        ],
      ),
    );
  }
}
