import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/date_converter.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/loan/loan_list_controller.dart';
import 'package:viser_bank/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/column/bottom_sheet_column.dart';
import 'package:viser_bank/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';

class LoanListBottomSheet{

  void bottomSheet(BuildContext context, int index){
    CustomBottomSheet(child: GetBuilder<LoanListController>(builder: (controller)=>Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BottomSheetTopRow(header: MyStrings.loanInformation),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  header: MyStrings.amount,
                  body: '${controller.currencySymbol}${Converter.formatNumber(controller.loanList[index].amount??'')}',
                )
            ),
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  alignmentEnd: true,
                  header: MyStrings.needToPay,
                  body: '${controller.currencySymbol}${controller.getNeedToPayAmount(index)}',
                )
            ),
          ],
        ),

        const SizedBox(height: Dimensions.space20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  header: MyStrings.installmentAmount,
                  body: "${controller.currencySymbol}${Converter.formatNumber(controller.loanList[index].perInstallment??'')}",
                )
            ),
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  alignmentEnd: true,
                  header: MyStrings.installmentInterval,
                  body: '${controller.loanList[index].installmentInterval??'0'} ${MyStrings.days.tr}',
                )
            ),
          ],
        ),
        const SizedBox(height: Dimensions.space20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  header: MyStrings.totalInstallment,
                  body: controller.loanList[index].totalInstallment??'0',
                )
            ),
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  alignmentEnd: true,
                  header: MyStrings.givenInstallment,
                  body: controller.loanList[index].givenInstallment??'0',
                )
            ),
          ],
        ),
        const SizedBox(height: Dimensions.space20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  header: MyStrings.nextInstallment,
                  body: DateConverter.isoStringToLocalDateOnly(controller.loanList[index].nextInstallment?.installmentDate??''),
                )
            ),
            Expanded(
                flex: 1,
                child: BottomSheetColumn(
                  alignmentEnd: true,
                  header: MyStrings.paidAmount,
                  body: "${controller.currencySymbol}${Converter.mul(controller.loanList[index].givenInstallment??'0',controller.loanList[index].perInstallment??'0')}",
                )
            ),
          ],
        ),
        const WidgetDivider(),
        RoundedButton(
          text:MyStrings.installments,
            press: () {
              Get.toNamed(RouteHelper.loanInstallmentLogScreen,arguments: controller.loanList[index].loanNumber);
          }),
      ],
    ))).customBottomSheet(context);
  }
}