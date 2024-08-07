import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rideshare/ui/common/app_colors.dart';
import 'package:rideshare/ui/common/app_strings.dart';
import 'package:rideshare/ui/common/ui_helpers.dart';
import 'package:rideshare/ui/common/uihelper/button_helper.dart';
import 'package:rideshare/ui/common/uihelper/text_helper.dart';
import 'package:stacked/stacked.dart';

import '../../common/uihelper/text_veiw_helper.dart';
import 'editprofile_viewmodel.dart';

class EditprofileView extends StackedView<EditprofileViewModel> {
  const EditprofileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditprofileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          title: text_helper(
            data: "Edit Profile",
            font: montserrat,
            color: kcDarkGreyColor,
            size: fontSize14,
            bold: true,
          ),
        ),
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                input("Enter First Name", viewModel.firstNameController,
                    Icons.person, true),
                input("Enter Last Name", viewModel.lastNameController,
                    Icons.person, true),
                viewModel.sharedpref.readString('cat') == "rider"
                    ? input("Enter Bike / Car Number",
                        viewModel.bikeNumController, Icons.bike_scooter, false)
                    : const SizedBox.shrink(),
                viewModel.sharedpref.readString('cat') == "rider"
                    ? input(
                        "Enter License Number",
                        viewModel.licenseNumController,
                        Icons.edit_document,
                        false)
                    : const SizedBox.shrink(),
                button_helper(
                    onpress: () => viewModel.update(context),
                    color: kcPrimaryColor,
                    width: screenWidth(context),
                    child: text_helper(
                        data: "Update",
                        font: montserrat,
                        color: kcDarkGreyColor,
                        size: fontSize14,
                        bold: true)),
              ],
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
  void onViewModelReady(EditprofileViewModel viewModel) {
    viewModel.bikeNumController.text = viewModel.sharedpref.readString('bike');
    viewModel.licenseNumController.text =
        viewModel.sharedpref.readString('lic');
    viewModel.firstNameController.text =
        viewModel.sharedpref.readString('fname');
    viewModel.lastNameController.text =
        viewModel.sharedpref.readString('lname');
    super.onViewModelReady(viewModel);
  }

  @override
  EditprofileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditprofileViewModel();
}
