import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/otp/otp_controller.dart';
import 'package:viser_bank/data/repo/otp/otp_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/otp_field_widget/otp_field_widget.dart';
import 'package:viser_bank/views/components/timer/timer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(OtpRepo(apiClient: Get.find()));
    final controller = Get.put(OtpController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String nextPageRoute = Get.arguments[0]??'';
      String otpId = Get.arguments[1];
      String otpType = Get.arguments[2];
      controller.nextPageUrl = nextPageRoute;
      controller.otpId = otpId;
      controller.otpType = otpType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor:MyColor.getScreenBgColor2(),
          appBar: const CustomAppBar(title: MyStrings.otpVerification),
          body: GetBuilder<OtpController>(
            builder: (controller) =>  SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.space35),
                      Visibility(
                        visible: !controller.isOtpExpired,
                        child: OtpTimer(
                          duration: controller.time,
                          onTimeComplete: (){
                          controller.makeOtpExpired(true);
                        }, otpType: controller.otpType,),
                      ),
                      Visibility(
                        visible: controller.isOtpExpired,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(MyStrings.otpHasBeenExpired.tr, style: interRegularDefault.copyWith(color: MyColor.redCancelTextColor)),
                          SizedBox(width: controller.resendLoading?Dimensions.space10:2),
                          controller.resendLoading?
                          Container(margin:const EdgeInsets.only(left: 5,top: 5),height:20,width:20,child: const CircularProgressIndicator(color: MyColor.primaryColor)):
                          GestureDetector(
                            onTap: (){
                              controller.sendCodeAgain();
                            },
                            child: Text(MyStrings.resend.tr, style: interRegularDefault.copyWith(color: MyColor.primaryColor,decoration: TextDecoration.underline)),
                          )
                        ],
                      )),
                      const SizedBox(height: Dimensions.space25),
                      OTPFieldWidget(
                        onChanged: (value) {
                          controller.currentText = value;
                        },
                      ),
                      const SizedBox(height: Dimensions.space30),
                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                        text: MyStrings.verify.tr,
                        textColor: MyColor.colorWhite,
                        press: (){
                          controller.submitOtp(controller.currentText);
                        },
                        color: MyColor.primaryColor,
                      ),
                      const SizedBox(height: Dimensions.space30),
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }
}
