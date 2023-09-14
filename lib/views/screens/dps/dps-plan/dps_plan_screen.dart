import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/data/controller/dps/dps_plan_controller.dart';
import 'package:viser_bank/views/components/custom_loader.dart';
import 'package:viser_bank/views/components/no_data/no_data_found_screen.dart';
import 'package:viser_bank/views/screens/dps/dps-plan/widget/dps_plan_card.dart';

class DPSPlanScreen extends StatefulWidget {

  const DPSPlanScreen({Key? key}) : super(key: key);

  @override
  State<DPSPlanScreen> createState() => _DPSPlanScreenState();
}

class _DPSPlanScreenState extends State<DPSPlanScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DPSPlanController>(
      builder: (controller) =>
      controller.isLoading ? const CustomLoader() : controller.planList.isEmpty ? const Center(
        child: NoDataFoundScreen(),
      ) : ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.planList.length,
        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
        itemBuilder: (context, index) => DPSPlanCard(index: index),
      ),
    );
  }
}
