import 'package:rideshare/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:rideshare/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:rideshare/ui/views/home/home_view.dart';
import 'package:rideshare/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rideshare/services/sharedpref_service_service.dart';
import 'package:rideshare/services/fir_service.dart';
import 'package:rideshare/ui/views/login/login_view.dart';
import 'package:rideshare/ui/views/category/category_view.dart';
import 'package:rideshare/ui/views/registration/registration_view.dart';
import 'package:rideshare/ui/views/wallet/wallet_view.dart';
import 'package:rideshare/ui/views/chat/allchats/allchats_view.dart';
import 'package:rideshare/ui/views/chat/chating/chating_view.dart';
import 'package:rideshare/ui/views/editprofile/editprofile_view.dart';
import 'package:rideshare/ui/views/forgetpassword/forgetpassword_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: CategoryView),
    MaterialRoute(page: RegistrationView),
    MaterialRoute(page: WalletView),
    MaterialRoute(page: AllchatsView),
    MaterialRoute(page: ChatingView),
    MaterialRoute(page: EditprofileView),
    MaterialRoute(page: ForgetpasswordView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SharedprefServiceService),
    LazySingleton(classType: FirService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
