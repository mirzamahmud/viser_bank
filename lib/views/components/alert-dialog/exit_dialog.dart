
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';



  showExitDialog(BuildContext context){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.getCardBg(),
      width: 300,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: MyStrings.exitTitle.tr,
      titleTextStyle:interRegularDefault.copyWith(color: MyColor.getTextColor(),fontSize: Dimensions.fontLarge),
      showCloseIcon: false,
      btnCancel: RoundedButton(text: MyStrings.no.tr, press: (){
        Navigator.pop(context);
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.getHintTextColor(),),
      btnOk: RoundedButton(text: MyStrings.yes.tr, press: (){
        SystemNavigator.pop();
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.red,textColor: MyColor.colorWhite,),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
    ).show();
  }
