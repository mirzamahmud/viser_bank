import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/fdr/fdr_plan_controller.dart';
import 'package:viser_bank/views/components/animated_widget/expanded_widget.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';
import 'package:viser_bank/views/screens/fdr/fdr-plan/widget/apply_fdr_bottom_sheet.dart';
import 'package:viser_bank/views/screens/fdr/widget/fdr_card_middle_section.dart';

class FDRCard extends StatefulWidget {
  final int index;

  const FDRCard({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  State<FDRCard> createState() => _FDRCardState();
}

class _FDRCardState extends State<FDRCard> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<FDRPlanController>(
      builder: (controller) => GestureDetector(
        onTap: (){
          controller.selectedIndex == widget.index ? controller.changeIndex(-1) : controller.changeIndex(widget.index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space15,
                    bottom: widget.index == controller.selectedIndex ? 0 : Dimensions.space15
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                           ( controller.planList[widget.index].name ?? "").tr,
                            style: interRegularDefault.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)
                        ),
                        const SizedBox(height: Dimensions.space5),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: controller.planList[widget.index].interestRate ?? "0.00",
                                    style: interRegularMediumLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w600)
                                ),
                                TextSpan(
                                    text: "%",
                                    style: interRegularLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w600)
                                ),
                                TextSpan(
                                    text: " / ",
                                    style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)
                                ),
                                TextSpan(
                                    text: "${controller.planList[widget.index].installmentInterval} ${MyStrings.days.tr}",
                                    style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor.primaryColor.withOpacity(0.08),
                            shape: BoxShape.circle
                        ),
                        child: Icon(
                            widget.index == controller.selectedIndex ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: MyColor.smallTextColor1,
                            size: 15)
                    )
                  ],
                ),
              ),
              ExpandedSection(
                expand: widget.index == controller.selectedIndex,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WidgetDivider(),
                    FdrCardMiddleSection(
                        lockPeriod: "${controller.planList[widget.index].lockedDays} ${MyStrings.days.tr}",
                        profitRate: "${controller.planList[widget.index].interestRate}%",
                        minimum: "${controller.currencySymbol}${Converter.formatNumber(controller.planList[widget.index].minimumAmount ?? "0.00")}",
                        maximum: "${controller.currencySymbol}${Converter.formatNumber(controller.planList[widget.index].maximumAmount ?? "0.00")}",
                        profitEvery: "${controller.planList[widget.index].installmentInterval} ${MyStrings.days.tr}",
                    ),
                    const WidgetDivider(lineColor: Colors.transparent,),
                    Padding(
                      padding: const EdgeInsets.only(left: Dimensions.space15, bottom: Dimensions.space20, right: Dimensions.space15),
                      child: RoundedButton(
                          press: (){
                            ApplyFDRBottomSheet().bottomSheet(context, widget.index);
                          },
                          text: MyStrings.applyNow
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
