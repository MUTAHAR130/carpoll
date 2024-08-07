import 'package:rideshare/ui/common/app_colors.dart';
import 'package:rideshare/ui/common/app_strings.dart';
import 'package:rideshare/ui/common/ui_helpers.dart';
import 'package:rideshare/ui/common/uihelper/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_veiw_helper.dart';
import 'registration_viewmodel.dart';

class RegistrationView extends StackedView<RegistrationViewModel> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text_helper(
                    data: viewModel.sharedpref.readString('cat') == "rider"
                        ? "Rider Details"
                        : "Passenger Details",
                    font: poppins,
                    color: kcDarkGreyColor,
                    size: fontSize16,
                    bold: true,
                    textDecoration: TextDecoration.underline,
                  ),
                  verticalSpaceTiny,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: screenWidthCustom(context, 0.45),
                          child: input(
                              "Enter First Name",
                              viewModel.firstNameController,
                              Icons.person,
                              true)),
                      SizedBox(
                          width: screenWidthCustom(context, 0.45),
                          child: input(
                              "Enter Last Name",
                              viewModel.lastNameController,
                              Icons.person,
                              true)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text_helper(
                          data: "Enter Email",
                          font: poppins,
                          bold: true,
                          color: kcDarkGreyColor,
                          size: fontSize12),
                      text_view_helper(
                          hint: "",
                          margin:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
                          showicon: true,
                          icon: Icon(Icons.alternate_email),
                          outborder:
                              Border.all(width: 1, color: kcDarkGreyColor),
                          inputBorder: InputBorder.none,
                          controller: viewModel.EmailController),
                    ],
                  ),
                  input("Enter Phone Number", viewModel.phoneNumController,
                      Icons.phone, false),
                  viewModel.sharedpref.readString('cat') == "rider"
                      ? input("Enter Bike / Car Number",
                          viewModel.bikeNumController, Icons.bike_scooter, true)
                      : const SizedBox.shrink(),
                  viewModel.sharedpref.readString('cat') == "rider"
                      ? input(
                          "Enter License Number",
                          viewModel.licenseNumController,
                          Icons.edit_document,
                          false)
                      : const SizedBox.shrink(),
                  text_helper(
                      data: "Enter Password",
                      font: poppins,
                      color: kcDarkGreyColor,
                      size: fontSize12,
                      bold: true),
                  Container(
                    padding: const EdgeInsetsDirectional.all(5),
                    margin: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                              controller: viewModel.PasswordController),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text_helper(
                              data: "Enter Date of Birth",
                              font: poppins,
                              color: kcDarkGreyColor,
                              size: fontSize12,
                              bold: true),
                          InkWell(
                            onTap: () => viewModel.selectdob(context),
                            child: Container(
                              width: screenWidthCustom(context, 0.45),
                              padding: const EdgeInsetsDirectional.all(10),
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: kcDarkGreyColor),
                                  color: white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.date_range),
                                  text_helper(
                                      data: viewModel
                                              .birthDateController.text.isEmpty
                                          ? "DD-MM-YYY"
                                          : viewModel.birthDateController.text,
                                      font: poppins,
                                      color: kcDarkGreyColor,
                                      size: fontSize14)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text_helper(
                              data: "Select Gender",
                              font: poppins,
                              color: kcDarkGreyColor,
                              size: fontSize12,
                              bold: true),
                          Container(
                            width: screenWidthCustom(context, 0.45),
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: kcDarkGreyColor),
                                color: white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.transgender),
                                DropdownButton<String>(
                                  value: viewModel.selgender,
                                  onChanged: (String? newValue) {
                                    viewModel.selgender = newValue!;
                                    viewModel.notifyListeners();
                                  },
                                  items: viewModel.gender
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: text_helper(
                                          data: value,
                                          font: poppins,
                                          color: kcDarkGreyColor,
                                          size: fontSize14),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_helper(
                          onpress: () => viewModel.back(),
                          color: kcPrimaryColor,
                          margin:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
                          width: screenWidthCustom(context, 0.3),
                          child: text_helper(
                              data: "Previous",
                              font: poppins,
                              color: kcDarkGreyColor,
                              size: fontSize12,
                              bold: true)),
                      button_helper(
                          onpress: () => viewModel.register(context),
                          color: kcPrimaryColor,
                          margin:
                              const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 5),
                          width: screenWidthCustom(context, 0.3),
                          child: text_helper(
                              data: "Next",
                              font: poppins,
                              color: kcDarkGreyColor,
                              size: fontSize12,
                              bold: true)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget input(String title, TextEditingController textEditingController,
      IconData iconData, bool check) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text_helper(
            data: title,
            font: poppins,
            bold: true,
            color: kcDarkGreyColor,
            size: fontSize12),
        text_view_helper(
            hint: "",
            textInputType: check ? TextInputType.text : TextInputType.number,
            margin: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
            formatter: [
              FilteringTextInputFormatter.allow(
                  check ? getRegExpstring() : getRegExpint())
            ],
            showicon: true,
            icon: Icon(iconData),
            outborder: Border.all(width: 1, color: kcDarkGreyColor),
            inputBorder: InputBorder.none,
            controller: textEditingController),
      ],
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewModel();
}
