import 'package:flutter/material.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/views/components/column/card_column.dart';
import 'package:viser_bank/views/components/status/status_widget.dart';
import 'package:viser_bank/views/components/widget-divider/widget_divider.dart';

class TransferHistoryCard extends StatelessWidget {

  final String trxValue,status, amount,accountName;
  final Color statusBgColor;
  final VoidCallback onPressed;

  const TransferHistoryCard({
    Key? key,
    required this.trxValue,
    required this.status,
    required this.statusBgColor,
    required this.amount,
    required this.accountName,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
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
                  CardColumn(header: MyStrings.trxNo, body: trxValue),
                  CardColumn(header: MyStrings.amount, body: amount)
                ],
              ),
              const WidgetDivider(space: Dimensions.space10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardColumn(header: MyStrings.accountName, body: accountName),
                  StatusWidget(
                    needBorder: true,
                    status: status,
                    backgroundColor: statusBgColor,
                    borderColor: statusBgColor,
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
