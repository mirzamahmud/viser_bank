import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/dimensions.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/style.dart';
import 'package:viser_bank/data/controller/auth/login_controller.dart';
import 'package:viser_bank/views/components/buttons/rounded_button.dart';
import 'package:viser_bank/views/components/buttons/rounded_loading_button.dart';
import 'package:viser_bank/views/components/text-field/custom_text_field.dart';
import 'package:viser_bank/views/screens/auth/login/widget/bottom_section.dart';

class LoginForm extends StatefulWidget {
  
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              labelText: MyStrings.usernameOrEmail,
              textInputType: TextInputType.name,
              hintText: MyStrings.enterUsernameOrEmail,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              nextFocus: controller.passwordFocusNode,
              inputAction: TextInputAction.next,
              onChanged: (value){},
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.fieldErrorMsg.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height:Dimensions.space20),
            CustomTextField(
              labelText: MyStrings.password,
              isPassword: true,
              hintText: MyStrings.enterYourPassword,
              onChanged: (value){},
              isShowSuffixIcon: true,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              inputAction: TextInputAction.go,
              onSubmitted:(value){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.fieldErrorMsg.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height:Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.changeRememberMe();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                            activeColor: MyColor.primaryColor,
                            value: controller.remember,
                            side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                                width: 1.0,
                                color: controller.remember ? MyColor.transparentColor : MyColor.colorGrey),
                            ),
                            onChanged: (value) {
                              controller.changeRememberMe();
                            }
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Text(MyStrings.rememberMe.tr,
                        style: interRegularSmall.copyWith(color: MyColor.colorBlack),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    controller.clearData();
                    controller.forgetPassword();
                  },
                  child: Text(MyStrings.loginForgotPassword.tr, style: interRegularSmall.copyWith(color: MyColor.primaryColor,decoration: TextDecoration.underline)),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space35,),
            controller.isSubmitLoading ? const RoundedLoadingBtn() : RoundedButton(
              text: MyStrings.signIn,
              color: MyColor.primaryColor,
              textColor: MyColor.colorWhite,
              press: (){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              }
            ),
            const SizedBox(height: Dimensions.space40),
            const BottomSection()
          ],
        ),
      ),
    );
  }
}