import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/auth/auth/registration_controller.dart';
import 'package:viser_bank/data/repo/auth/general_setting_repo.dart';
import 'package:viser_bank/data/repo/auth/signup_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/auth/registration/widget/registration_form.dart';

import '../../../../core/utils/my_strings.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor2(),
            appBar: const CustomAppBar(title: MyStrings.signUp,fromAuth: true,),
            body: controller.isLoading ? const CustomLoader() : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.signUpTitle.tr, style: interSemiBoldExtraLarge.copyWith(fontSize:Dimensions.fontHeader2,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.2),
                        child: Text(MyStrings.signUpSologan.tr, textAlign: TextAlign.left,style: interRegularDefault.copyWith(color: MyColor.getGreyText()),)),
                    const SizedBox(height: Dimensions.space40),
                    const RegistrationForm()
                    ],
                  ),
                ),
              ),
            )
          ),
      ),
      );
  }
}
