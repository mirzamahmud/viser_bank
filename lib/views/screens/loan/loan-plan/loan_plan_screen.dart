import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/data/controller/loan/loan_plan_controller.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found.dart';
import 'package:viser_bank/views/screens/loan/loan-plan/widget/apply_loan_bottom_sheet.dart';
import 'package:viser_bank/views/screens/loan/widget/loan_card.dart';


class LoanPlanScreen extends StatefulWidget {

  const LoanPlanScreen({Key? key}) : super(key: key);

  @override
  State<LoanPlanScreen> createState() => _LoanPlanScreenState();
}

class _LoanPlanScreenState extends State<LoanPlanScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoanPlanController>(builder: (controller) {
      return controller.isLoading ? const CustomLoader() : controller.planList
          .isEmpty ? const NoDataWidget() : ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.planList.length,
            separatorBuilder: (context, index) =>
            const SizedBox(height: Dimensions.space10),
            itemBuilder: (context, index) =>
                LoanCard(
                    index: index,
                    cardStatusTitle: controller.planList[index].name ?? '',
                    percentRate: controller.planList[index].perInstallment ?? '0',
                    takeMin: '${controller.currencySymbol}${Converter.formatNumber(controller.planList[index].minimumAmount ?? '')}',
                    takeMax: ' ${controller.currencySymbol}${Converter.formatNumber(controller.planList[index].maximumAmount ?? '0')}',
                    perInstallment: '${Converter.roundDoubleAndRemoveTrailingZero(controller.planList[index].perInstallment ?? '')}%',
                    installmentInterval: controller.planList[index].installmentInterval ?? '',
                    totalInstallment: controller.planList[index].totalInstallment ?? '',
                    onPressed: () {
                      ApplyLoanBottomSheet().bottomSheet(context, index);
                    }
                ),
          );
    });
  }


}
