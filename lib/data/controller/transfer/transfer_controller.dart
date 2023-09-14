
import 'package:get/get.dart';
import 'package:viser_bank/data/repo/transfer_repo/transfer_repo.dart';

class TransferController extends GetxController{

  TransferRepo repo;
  bool isWireTransferEnable = true;
  TransferController({required this.repo});

  int selectedIndex = -1;

  void changeIndex(int index){
    selectedIndex = index;
    update();
  }

  void checkWireTransferStatus() {
    isWireTransferEnable = repo.apiClient.isWireTransferEnable();
    update();
  }


}