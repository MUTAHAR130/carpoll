import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../services/sharedpref_service_service.dart';
import '../chating/chating_view.dart';

class AllchatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefServiceService>();

  void move(String idd, String did) {
    _navigationService.navigateWithTransition(
        ChatingView(
          id: idd,
          did: did,
        ),
        routeName: Routes.chatingView,
        transitionStyle: Transition.rightToLeft);
  }
}
