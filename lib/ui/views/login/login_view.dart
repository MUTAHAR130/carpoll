import 'package:rideshare/ui/common/app_colors.dart';
import 'package:rideshare/ui/common/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/bplogo.png',
                      width: screenWidthCustom(context, 0.5),
                      height: screenWidthCustom(context, 0.5),
                    ),
                  ),
                  verticalSpaceSmall,
                  text_helper(
                      data: " Enter phone Number ",
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14,
                      bold: true),
                  text_view_helper(
                      hint: "",
                      showicon: true,
                      textInputType: TextInputType.phone,
                      icon: const Icon(Icons.phone),
                      outborder: Border.all(width: 1, color: kcDarkGreyColor),
                      inputBorder: InputBorder.none,
                      controller: viewModel.phone),
                  text_helper(
                      data: " Enter Password",
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize14,
                      bold: true),
                  Container(
                    padding: const EdgeInsetsDirectional.all(5),
                    margin: const EdgeInsetsDirectional.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: kcDarkGreyColor),
                        color: white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidthCustom(context, 0.8),
                          child: text_view_helper(
                              hint: "",
                              showicon: true,
                              obsecure: viewModel.obsure,
                              padding: const EdgeInsetsDirectional.all(0),
                              margin: const EdgeInsetsDirectional.all(0),
                              inputBorder: InputBorder.none,
                              icon: const Icon(Icons.password),
                              controller: viewModel.pass),
                        ),
                        InkWell(
                          onTap: () => viewModel.updateobsure(),
                          child: Icon(viewModel.obsure
                              ? Icons.remove_red_eye_sharp
                              : Icons.remove_red_eye_outlined),
                        ),
                        horizontalSpaceTiny,
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => viewModel.forgetpassword(),
                      child: text_helper(
                          data: "Forget Password",
                          font: poppins,
                          color: kcDarkGreyColor,
                          size: fontSize12),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: button_helper(
                      onpress: () => viewModel.login(context),
                      color: kcPrimaryColor,
                      width: screenWidthCustom(context, 0.3),
                      child: text_helper(
                          data: "LOGIN",
                          font: roboto,
                          color: kcDarkGreyColor,
                          size: fontSize16,
                          bold: true),
                    ),
                  ),
                  InkWell(
                    onTap: () => viewModel.transfer(),
                    child: Align(
                      alignment: Alignment.center,
                      child: text_helper(
                          data: "Sign In or Register",
                          textDecoration: TextDecoration.underline,
                          font: poppins,
                          color: kcDarkGreyColor,
                          size: fontSize12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
