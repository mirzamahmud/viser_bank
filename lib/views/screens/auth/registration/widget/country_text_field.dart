import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';

class CountryTextField extends StatelessWidget {

  final String text;
  final VoidCallback press;

  const CountryTextField({Key? key,
    required this.text,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15),
        decoration: BoxDecoration(
          color: MyColor.transparentColor,
          border: const Border(bottom:BorderSide(color: MyColor.borderColor))
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(text.tr,style: interRegularDefault.copyWith(color: MyColor.colorBlack),),
              Icon(Icons.expand_more_rounded,color: MyColor.getGreyText(),size: 20,)
            ],
          ),
      ),
    );
  }
}
