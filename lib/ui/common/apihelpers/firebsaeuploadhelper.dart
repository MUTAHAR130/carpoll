// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:rideshare/services/fir_service.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import '../../../app/app.locator.dart';

class FirebaseHelper {
  static Future<String> uploadFile(File? file, String phone) async {
    final fireService = locator<FirService>();

    String filename = path.basename(file!.path);
    String extension = path.extension(file.path);
    String randomChars = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFilename = '$filename-$randomChars$extension';

    UploadTask uploadTask = fireService.storage
        .child('user')
        .child(phone)
        .child(uniqueFilename)
        .putFile(file);
    await uploadTask;
    String downloadURL = await fireService.storage
        .child('user')
        .child(phone)
        .child(uniqueFilename)
        .getDownloadURL();
    return downloadURL;
  }

  static Future<void> sendnotificationto(
      String notificationid, String title, String body) async {
    String keys =
        'AAAAhxNpXdY:APA91bFksXZpnacBUBcGaczuCwcqMUy2uJ1DPayv3HFqcSb_PmifSoW4yk-NCkO5vSvjV0N3P1qCSNdHR2sSgPpVjpxBzvz8V0BbTKvuqya6Nk2gHgYiVB9GktWaoYoaLMK-MQEiUEXF';
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode({
          'to': notificationid,
          'priority': 'high',
          'notification': {'title': title, 'body': body}
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$keys'
        });
  }
}
