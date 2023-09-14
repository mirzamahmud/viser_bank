import 'dart:convert';

import 'package:get/get.dart';
import 'package:viser_bank/core/helper/shared_preference_helper.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/data/model/authorization/authorization_response_model.dart';
import 'package:viser_bank/data/model/general_setting/general_settings_response_model.dart';
import 'package:viser_bank/data/model/global/response_model/response_model.dart';
import 'package:viser_bank/data/repo/auth/general_setting_repo.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';

class MenuController extends GetxController  {

  GeneralSettingRepo repo;
  bool isLoading = true;
  bool noInternet = false;

  bool balTransferEnable = true;
  bool langSwitchEnable = true;
  bool isDepositEnable = true;
  bool isWithdrawEnable = true;

  MenuController({required this.repo});

  void loadData()async{
    GeneralSettingsResponseModel model = repo.apiClient.getGSData();
    isDepositEnable = model.data?.generalSetting?.modules?.deposit=='0'?false:true;
    isWithdrawEnable = model.data?.generalSetting?.modules?.withdraw=='0'?false:true;
    isLoading = true;
    update();
    await configureMenuItem();
    isLoading = false;
    update();
  }

  configureMenuItem()async{

    ResponseModel response = await repo.getGeneralSetting();

    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
        bool langStatus = true; // model.data?.generalSetting?.langSwitch == '0'?false:true;
        langSwitchEnable = langStatus;
        repo.apiClient.storeGeneralSetting(model);
        update();
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList:model.message?.error??message);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList:[response.message]);
      return;
    }
  }

  bool logoutLoading = false;
  Future<void>logout()async{
    List<String>msg = [];
    logoutLoading = true;
    update();
    ResponseModel response = await repo.logout();
    if(response.statusCode == 200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase() == MyStrings.success.toLowerCase() || model.status?.toLowerCase() == 'ok'){
        msg.addAll(model.message?.success??[MyStrings.logoutSuccessMsg]);
      } else{
        msg.add(MyStrings.logoutSuccessMsg);
      }
    } else{
      msg.add(MyStrings.logoutSuccessMsg);
    }
    logoutLoading = false;
    update();
    repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
   /* repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.screenLockPin, '');*/
    Get.offAllNamed(RouteHelper.loginScreen);
    CustomSnackBar.success(successList: msg);
  }

}