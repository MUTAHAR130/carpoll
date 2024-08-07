import 'package:rideshare/services/sharedpref_service_service.dart';
import 'package:stacked/stacked.dart';
import 'package:rideshare/app/app.locator.dart';
import 'package:rideshare/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../home/home_view.dart';
import '../login/login_view.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedpref = locator<SharedprefServiceService>();

  Future runStartupLogic() async {
    await _sharedpref.initialize();
    if (_sharedpref.contains('auth') &&
        _sharedpref.readString('auth') == 'true') {
      _navigationService.replaceWithTransition(const HomeView(),
          routeName: Routes.homeView, transitionStyle: Transition.rightToLeft);
    } else {
      _navigationService.replaceWithTransition(const LoginView(),
          routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
    }
  }
}
