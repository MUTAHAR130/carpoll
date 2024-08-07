import 'package:rideshare/services/fir_service.dart';
import 'package:rideshare/services/sharedpref_service_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/apihelpers/firebsaeuploadhelper.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../home/home_view.dart';

class RegistrationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _fireService = locator<FirService>();
  final sharedpref = locator<SharedprefServiceService>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController riderController = TextEditingController();
  TextEditingController bikeNumController = TextEditingController();
  TextEditingController licenseNumController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController phoneNumController =
      MaskedTextController(mask: '0000-0000000');
  TextEditingController birthDateController = TextEditingController();

  String selgender = "male";
  List<String> gender = ["male", "female"];

  bool obsure = true;
  void updateobsure() {
    obsure = !obsure;
    notifyListeners();
  }

  Future<void> selectdob(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      birthDateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      notifyListeners();
    }
  }

  void register(BuildContext context) {
    if (phoneNumController.text.isEmpty ||
        EmailController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        PasswordController.text.isEmpty ||
        birthDateController.text.isEmpty) {
      show_snackbar(context, "Fill all Fields");
    } else if (phoneNumController.text.length != 12) {
      show_snackbar(context, "Number is not correct");
    } else if (!validateEmail(EmailController.text)) {
      show_snackbar(context, "Email is not correct");
    } else {
      displayprogress(context);
      Future<bool> result = _fireService.messaging.getToken().then((value) {
        sharedpref.setString('deviceid', value.toString());
        sharedpref.setString('fname', firstNameController.text);
        sharedpref.setString('lname', firstNameController.text);
        sharedpref.setString('number', phoneNumController.text);
        sharedpref.setString('gender', selgender);
        sharedpref.setString('email', EmailController.text);
        sharedpref.setString('bike', bikeNumController.text);
        sharedpref.setString('lic', licenseNumController.text);
        sharedpref.setString('dob', birthDateController.text);
        return ApiHelper.registration(
            phoneNumController.text,
            firstNameController.text,
            lastNameController.text,
            selgender,
            PasswordController.text,
            EmailController.text,
            bikeNumController.text,
            licenseNumController.text,
            birthDateController.text,
            sharedpref.readString("cat"),
            value.toString(),
            context);
      });
      result.then((value) async {
        if (value) {
          sharedpref.setString('auth', 'true');
          await ApiHelper.registerwallet(phoneNumController.text, context);
          await FirebaseHelper.sendnotificationto(
              sharedpref.readString("deviceid"),
              "Sucessfully signup",
              "You have sucessfully signup");
          hideprogress(context);
          _navigationService.clearStackAndShow(Routes.homeView);
          _navigationService.replaceWithTransition(const HomeView(),
              routeName: Routes.homeView,
              transitionStyle: Transition.rightToLeft);
        } else {
          hideprogress(context);
          show_snackbar(context, 'try again later');
        }
      });
    }
  }

  void back() {
    _navigationService.back();
  }

  bool validateEmail(String value) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
