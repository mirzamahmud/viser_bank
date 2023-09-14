import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/transaction/transaction_controller.dart';
import 'package:viser_bank/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:viser_bank/views/components/row_item/bottom_sheet_top_row.dart';

showTrxBottomSheet(List<String>? list, int callFrom,String header, {required BuildContext context}){

  if (list != null && list.isNotEmpty) {
    CustomBottomSheet(
      backgroundColor: MyColor.getScreenBgColor1(),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetTopRow(header: header,bgColor: MyColor.colorWhite,),
        SizedBox(
          child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      String selectedValue = list[index];
                      final controller= Get.find<TransactionController>();
                      if(callFrom==1){
                        controller.changeSelectedTrxType(selectedValue);
                        controller.filterData();
                      }else if(callFrom==2){
                        controller.changeSelectedRemark(selectedValue);
                        controller.filterData();
                      }
                      Navigator.pop(context);
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.getCardBg()
                      ),
                      child: Text(
                        ' ${callFrom ==2 ? Converter.replaceUnderscoreWithSpace(list[index].capitalizeFirst??''):list[index]}',
                        style: interRegularDefault.copyWith(fontSize: Dimensions.fontDefault),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    )).customBottomSheet(context);
  }
}