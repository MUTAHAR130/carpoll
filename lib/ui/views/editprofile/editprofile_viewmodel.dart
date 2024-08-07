import 'package:flutter/cupertino.dart';
import 'package:rideshare/ui/common/apihelpers/apihelper.dart';
import 'package:rideshare/ui/common/uihelper/snakbar_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/sharedpref_service_service.dart';

class EditprofileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefServiceService>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bikeNumController = TextEditingController();
  TextEditingController licenseNumController = TextEditingController();

  Future<void> update(BuildContext context) async {
    bool c = await ApiHelper.updateuser(
        sharedpref.readString('number'),
        firstNameController.text,
        lastNameController.text,
        bikeNumController.text,
        licenseNumController.text);
    if (c) {
      sharedpref.setString('bike', bikeNumController.text);
      sharedpref.setString('lic', licenseNumController.text);
      sharedpref.setString('fname', firstNameController.text);
      sharedpref.setString('lname', lastNameController.text);
      show_snackbar(context, "Updated");
      _navigationService.back();
    } else {
      show_snackbar(context, "Try again later");
      _navigationService.back();
    }
  }
}
