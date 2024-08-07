import 'package:rideshare/services/sharedpref_service_service.dart';
import 'package:rideshare/ui/views/registration/registration_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../common/uihelper/snakbar_helper.dart';
import '../login/login_view.dart';

class CategoryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefServiceService>();

  String cat = '';

  void rest() {
    cat = 'rider';
    notifyListeners();
  }

  void simple() {
    cat = 'user';
    notifyListeners();
  }

  void next(BuildContext context) {
    if (cat == '') {
      show_snackbar(context, "Please Select a Category");
    } else {
      _sharedpref.setString("cat", cat);
      _navigationService.navigateWithTransition(const RegistrationView(),
          routeName: Routes.registrationView,
          transitionStyle: Transition.rightToLeft);
    }
  }

  void login() {
    _navigationService.replaceWithTransition(const LoginView(),
        routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
  }
}
