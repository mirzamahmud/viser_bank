import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/fdr/fdr_list_controller.dart';
import 'package:viser_bank/views/components/column/card_column.dart';
import 'package:viser_bank/views/components/status/status_widget.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';
import 'package:viser_bank/views/screens/fdr/my-fdr-list-screen/widget/fdr_list_bottom_sheet.dart';

class FDRListCard extends StatelessWidget {

  final int index;
  const FDRListCard({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FDRListController>(
      builder: (controller) => GestureDetector(
        onTap: () => FdrListBottomSheet().bottomSheet(context, index),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.space15),
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardColumn(
                    header:MyStrings.plan,
                    body: controller.fdrList[index].plan?.name ?? "",
                  ),
                  CardColumn(
                    alignmentEnd: true,
                    header:MyStrings.amount,
                    body: "${Converter.formatNumber(controller.fdrList[index].amount ?? "")} ${controller.currency}",
                  ),
                ],
              ),
              const WidgetDivider(space: Dimensions.space15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CardColumn(
                    header:MyStrings.fdrNo,
                    body: controller.fdrList[index].fdrNumber ?? "",
                  ),
                  StatusWidget(
                      needBorder: true,
                      status: controller.getStatusAndColor(index),
                      borderColor: controller.getStatusAndColor(index,isStatus: false),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
