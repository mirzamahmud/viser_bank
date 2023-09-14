import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/data/controller/fdr/fdr_controller.dart';
import 'package:viser_bank/data/controller/fdr/fdr_list_controller.dart';
import 'package:viser_bank/data/controller/fdr/fdr_plan_controller.dart';
import 'package:viser_bank/data/repo/fdr/fdr_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/tab/tab_container.dart';
import 'package:viser_bank/views/components/will_pop_widget.dart';
import 'package:viser_bank/views/screens/fdr/fdr-plan/fdr_plan_screen.dart';
import 'package:viser_bank/views/screens/fdr/my-fdr-list-screen/fdr_list_screen.dart';

import '../../../../core/utils/my_strings.dart';

class FDRScreen extends StatefulWidget {
  const FDRScreen({Key? key}) : super(key: key);

  @override
  State<FDRScreen> createState() => _FDRScreenState();
}

class _FDRScreenState extends State<FDRScreen> {



  @override
  void initState() {
    final arg = Get.arguments??'';
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FDRRepo(apiClient: Get.find()));
    final controller = Get.put(FDRController());
    if(arg.toString().isNotEmpty){controller.isPlan = false;}
    final fdrListController = Get.put(FDRListController(fdrRepo: Get.find()));
    final fdrPlanController = Get.put(FDRPlanController(fdrPlanRepo: Get.find()));
    super.initState();

   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     fdrPlanController.loadFDRPlanData();
     fdrListController.initialSelectedValue();
   });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FDRController>(builder: (controller)=>WillPopWidget(
      nextRoute: controller.getPreviousRoute(),
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar:  CustomAppBar(title: MyStrings.fdr,isForceBackHome: controller.getPreviousRoute()!=RouteHelper.notificationScreen,),
        body: Padding(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
              TabContainer(
                firstText:  MyStrings.fdrPlans,
                firstTabPress:(){
                  controller.changeTab(true);
                },
                isFirstSelected: controller.isPlan,
                secondText:  MyStrings.myFDRLists,
                secondTabPress: (){
                  controller.changeTab(false);
                },
              ),
              const SizedBox(height: Dimensions.space15),
              Expanded(
                child: controller.isPlan? const FDRPlanScreen() : const FDRListScreen(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
