import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'indicator/indicator.dart';

class CustomLoader extends StatelessWidget {

  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;

  const CustomLoader({
    Key? key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFullScreen?SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: SpinKitThreeBounce(
          color: MyColor.primaryColor,
          size: 18.0,
        )
      ),
    ):isPagination?Center(child: Padding(
        padding: const EdgeInsets.all(10),
        child: LoadingIndicator(strokeWidth: strokeWidth,))):
    const Center(
      child: SpinKitThreeBounce(
        color: MyColor.primaryColor,
        size: 18.0,
      )
    );
  }
}
