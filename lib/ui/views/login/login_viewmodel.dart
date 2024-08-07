import 'package:rideshare/services/fir_service.dart';
import 'package:rideshare/services/sharedpref_service_service.dart';
import 'package:rideshare/ui/views/category/category_view.dart';
import 'package:rideshare/ui/views/forgetpassword/forgetpassword_view.dart';
import 'package:rideshare/ui/views/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../common/apihelpers/apihelper.dart';
import '../../common/uihelper/snakbar_helper.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _fireService = locator<FirService>();
  final _sharedpref = locator<SharedprefServiceService>();

  TextEditingController phone = MaskedTextController(mask: '0000-0000000');
  TextEditingController pass = TextEditingController();

  bool obsure = true;
  void updateobsure() {
    obsure = !obsure;
    notifyListeners();
  }

  void login(BuildContext context) {
    if (phone.text.isEmpty || pass.text.isEmpty) {
      show_snackbar(context, "fill all fields");
    } else {
      displayprogress(context);
      var result = _fireService.messaging.getToken().then((value) {
        return ApiHelper.login(
            phone.text, pass.text, value.toString(), context);
      });
      result.then((value) {
        String cat = value['cat'] ?? "";
        _sharedpref.setString('deviceid', value.toString());
        _sharedpref.setString('fname', value['firstname']);
        _sharedpref.setString('lname', value['lastname']);
        _sharedpref.setString('number', phone.text);
        _sharedpref.setString('gender', value['gender']);
        _sharedpref.setString('email', value['email']);
        _sharedpref.setString('bike', value['bikenumber']);
        _sharedpref.setString('lic', value['licencenumber']);
        _sharedpref.setString('dob', value['dob']);
        _sharedpref.setString('cat', cat);

        _sharedpref.setString("auth", 'true');
        hideprogress(context);

        _navigationService.clearStackAndShow(Routes.homeView);
        _navigationService.replaceWithTransition(const HomeView(),
            routeName: Routes.homeView,
            transitionStyle: Transition.rightToLeft);
      });
    }
  }

  void transfer() {
    _navigationService.navigateWithTransition(const CategoryView(),
        routeName: Routes.categoryView,
        transitionStyle: Transition.rightToLeft);
  }

  void forgetpassword() {
    _navigationService.navigateWithTransition(const ForgetpasswordView(),
        routeName: Routes.forgetpasswordView,
        transitionStyle: Transition.rightToLeft);
  }
}
