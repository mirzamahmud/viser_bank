import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/helper/date_converter.dart';
import 'package:viser_bank/core/helper/string_format_helper.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/controller/dps/dps_installment_log_controller.dart';
import 'package:viser_bank/data/repo/dps/dps_repo.dart';
import 'package:viser_bank/data/services/api_service.dart';
import 'package:viser_bank/views/components/appbar/custom_appbar.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found.dart';
import 'package:viser_bank/views/screens/dps/my-dps-list-screen/sub-screen/widget/bottom_sheet.dart';
import 'package:viser_bank/views/screens/dps/my-dps-list-screen/sub-screen/widget/installment_log_list_item.dart';

class DPSInstallmentLogScreen extends StatefulWidget {

  const DPSInstallmentLogScreen({Key? key}) : super(key: key);

  @override
  State<DPSInstallmentLogScreen> createState() => _DPSInstallmentLogScreenState();
}

class _DPSInstallmentLogScreenState extends State<DPSInstallmentLogScreen> {


  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<DPSInstallmentLogController>().hasNext()){
        Get.find<DPSInstallmentLogController>().loadPaginationData();
      }
    }
  }


  @override
  void initState() {
    String trxId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DPSRepo(apiClient: Get.find()));
    final controller = Get.put(DPSInstallmentLogController(dpsRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.dpsId = trxId;
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DPSInstallmentLogController>(builder: (controller)=>Scaffold(
        backgroundColor: MyColor.getScreenBgColor1(),
        appBar: CustomAppBar(
          title: MyStrings.dpsInstallments,
          isShowActionBtn:true,
          actionIcon: Icons.info_outline,
          actionText: MyStrings.dpsInfo,
          press: (){
          DPSInstallmentBottomSheet().show(context);
        },),
        body: controller.isLoading?const CustomLoader() : controller.installmentLogList.isEmpty?const NoDataWidget():Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Dimensions.screenPadding),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            itemCount: controller.installmentLogList.length+1,
            separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
            itemBuilder: (context, index) {
              if (index == controller.installmentLogList.length) {
                return controller.hasNext()
                    ? const CustomLoader(isPagination: true,)
                    : const SizedBox();
              }
              return InstallmentLogItem(
                  serialNumber: '${index + 1}',
                  installmentDate: controller.installmentLogList[index].installmentDate ?? '',
                  giveOnDate: controller.installmentLogList[index].givenAt ?? '',
                  delayCharge: '${controller.currencySymbol}${Converter.formatNumber(controller.dps?.chargePerInstallment??'0')}',
                  delay: DateConverter.delayDate(controller.installmentLogList[index].installmentDate,controller.installmentLogList[index].givenAt));
            },
        ),
      ))
    ));
  }
}
