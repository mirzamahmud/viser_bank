import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_images.dart';
import 'package:viser_bank/core/utils/style.dart';

class PlanRow extends StatelessWidget {

  final String firstText, secondText;
  final double space;

  const PlanRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.space = 12
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(MyImages.check, height: 15, width: 15),
                const SizedBox(width: Dimensions.space10),
                Text(firstText.tr, style: interRegularDefault.copyWith(color: MyColor.smallTextColor1)),
              ],
            ),
            Text(secondText.tr, style: interRegularDefault.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(height: space)
      ],
    );
  }
}
