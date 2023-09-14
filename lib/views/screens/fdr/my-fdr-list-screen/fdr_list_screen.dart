import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/data/controller/fdr/fdr_list_controller.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found_screen.dart';
import 'package:viser_bank/views/screens/fdr/widget/fdr_list_card.dart';

class FDRListScreen extends StatefulWidget {

  const FDRListScreen({Key? key}) : super(key: key);

  @override
  State<FDRListScreen> createState() => _FDRListScreenState();
}

class _FDRListScreenState extends State<FDRListScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<FDRListController>().hasNext()){
        Get.find<FDRListController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    return GetBuilder<FDRListController>(
      builder: (controller) =>
        controller.isLoading ? const CustomLoader() : controller.fdrList.isEmpty ? const Center(
          child: NoDataFoundScreen(),
        ) :ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.fdrList.length+1,
          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
          itemBuilder: (context, index) {
            if(controller.fdrList.length==index){
              return controller.hasNext()?const CustomLoader(isPagination:true): const SizedBox();
            }
            return FDRListCard(index: index);
          },
        ),
    );
  }
}