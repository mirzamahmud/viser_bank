import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/account/profile_controller.dart';
import 'package:viser_bank/data/repo/account/profile_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';

import 'widget/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(isShowBackBtn: true, title: MyStrings.editProfile.tr, bgColor: MyColor.getAppbarBgColor()),
          body: GetBuilder<ProfileController>(
            builder: (controller) => controller.isLoading? const CustomLoader() : const SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: EditProfileForm(),
            ),
          ),
        ),
      ),
    );
  }
}
