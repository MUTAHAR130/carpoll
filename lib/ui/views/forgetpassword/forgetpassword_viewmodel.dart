import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:rideshare/app/app.locator.dart';
import 'package:rideshare/ui/common/apihelpers/apihelper.dart';
import 'package:stacked/stacked.dart';

import '../../../services/fir_service.dart';
import '../../common/uihelper/snakbar_helper.dart';

class ForgetpasswordViewModel extends BaseViewModel {
  final _fireService = locator<FirService>();

  TextEditingController phone = MaskedTextController(mask: '0000-0000000');
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();

  bool obsure = true;
  void updateobsure() {
    obsure = !obsure;
    notifyListeners();
  }

  bool show = true;
  String verficationidd = '';

  Future<void> change(BuildContext context) async {
    if (phone.text.isEmpty || pass.text.isEmpty || email.text.isEmpty) {
      show_snackbar(context, "fill all fields");
    } else if (otp.text.isEmpty) {
      show_snackbar(context, "enter otp");
    } else {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verficationidd, smsCode: otp.text);
      var check = await _fireService.auth.signInWithCredential(credential);
      bool c = await ApiHelper.forgetpassword(
          phone.text, pass.text, email.text, context);
      if (c) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> getotp(BuildContext context) async {
    if (phone.text.isEmpty || pass.text.isEmpty || email.text.isEmpty) {
      show_snackbar(context, "fill all fields");
    } else {
      displayprogress(context);
      await _fireService.auth.verifyPhoneNumber(
        phoneNumber: '+92${phone.text.toString().substring(1).replaceAll("-", "")}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _fireService.auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          hideprogress(context);
          show_snackbar(context, "try again later");
        },
        codeSent: (String verificationId, int? resendToken) async {
          hideprogress(context);
          verficationidd = verificationId;
          show = false;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
