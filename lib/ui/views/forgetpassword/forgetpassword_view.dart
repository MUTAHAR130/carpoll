import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rideshare/ui/common/app_colors.dart';
import 'package:rideshare/ui/common/app_strings.dart';
import 'package:rideshare/ui/common/uihelper/text_helper.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'forgetpassword_viewmodel.dart';

class ForgetpasswordView extends StackedView<ForgetpasswordViewModel> {
  const ForgetpasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgetpasswordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: text_helper(
            data: "Forget Password",
            font: poppins,
            color: kcDarkGreyColor,
            size: fontSize14,
            bold: true),
      ),
      body: Padding(
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
              viewModel.show
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            outborder:
                                Border.all(width: 1, color: kcDarkGreyColor),
                            inputBorder: InputBorder.none,
                            controller: viewModel.phone),
                        text_helper(
                            data: " Enter your email",
                            font: poppins,
                            color: kcDarkGreyColor,
                            size: fontSize14,
                            bold: true),
                        text_view_helper(
                            hint: "",
                            showicon: true,
                            textInputType: TextInputType.emailAddress,
                            icon: const Icon(Icons.mail),
                            outborder:
                                Border.all(width: 1, color: kcDarkGreyColor),
                            inputBorder: InputBorder.none,
                            controller: viewModel.email),
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
                              border:
                                  Border.all(width: 1, color: kcDarkGreyColor),
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
                          alignment: Alignment.center,
                          child: button_helper(
                            onpress: () => viewModel.getotp(context),
                            color: kcPrimaryColor,
                            width: screenWidth(context),
                            child: text_helper(
                                data: "GET OTP",
                                font: roboto,
                                color: kcDarkGreyColor,
                                size: fontSize16,
                                bold: true),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.all(15),
                          child: Pinput(
                            length: 6,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            controller: viewModel.otp,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: button_helper(
                            onpress: () => viewModel.change(context),
                            color: kcPrimaryColor,
                            width: screenWidth(context),
                            child: text_helper(
                                data: "CHANGE PASSWORD",
                                font: roboto,
                                color: kcDarkGreyColor,
                                size: fontSize16,
                                bold: true),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  ForgetpasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgetpasswordViewModel();
}
