// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../uihelper/snakbar_helper.dart';
import 'firebsaeuploadhelper.dart';

const url = 'http://10.0.2.2:3000/';
const registrationlink = "${url}register";
const loginlink = "${url}login";
const getuserlink = "${url}getuser";
const getoneuserlink = "${url}getoneuser";
const updateuserlink = "${url}updateuser";
const forgetpasswordlink = "${url}forgetpassword";

//service
const registerservicelink = "${url}registerservice";
const getservicelink = "${url}getservice";
const updatedservicelink = "${url}updatedservice";
const deleteservicelink = "${url}deleteservice";
const updatestatuslink = "${url}updatestatus";
const updatedmenuratinglink = "${url}updatedmenurating";

// wallet
const registerwalletlink = "${url}registerwallet";
const getwalletlink = "${url}getwallet";
const updatewalletlink = "${url}updatewallet";

// chat
const registerchatlink = "${url}registerchat";
const allchatbyidlink = "${url}allchatbyid";
const addchatlink = "${url}addchat";
const allchatbydidlink = "${url}allchatbydid";

class ApiHelper {
  // chat
  static Future<Map> registerchat(String uid, String did) async {
    try {
      var response = await http.post(Uri.parse(registerchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "uid": uid,
            "did": did,
            "c": [],
            "date": DateTime.now().toString(),
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> allchatbyid(String id) async {
    try {
      var response = await http.post(Uri.parse(allchatbyidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return {};
    }
  }

  static Future<List> allchatbydid(String did) async {
    try {
      var response = await http.post(Uri.parse(allchatbydidlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"did": did}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data['data']);
      return data['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addchat(String id, Map dataa, String sendto) async {
    try {
      var response = await http.post(Uri.parse(addchatlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "data": dataa}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      Map d = await getoneuser(sendto);
      await FirebaseHelper.sendnotificationto(
          d['deviceid'], "New Message", dataa['mess']);
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // wallets
  static Future<bool> registerwallet(
      String number, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerwalletlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "notpay": "0",
            "paid": "0",
            "topup": "0",
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<Map> getwallet(String number) async {
    try {
      var response = await http.post(Uri.parse(getwalletlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"number": number}));
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updatewallet(String number, String notpay, String paid,
      String topup, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatewalletlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "notpay": notpay,
            "paid": paid,
            "topup": topup,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  // service
  static Future<bool> registerservice(
      String number,
      String cat,
      String lats,
      String lons,
      String late,
      String lone,
      String adds,
      String adde,
      String dis,
      String ride,
      String price,
      String datetime,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registerservicelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "cat": cat,
            "lats": lats,
            "lons": lons,
            "late": late,
            "lone": lone,
            "adds": adds,
            "adde": adde,
            "dis": dis,
            "ride": ride,
            "price": price,
            "datetime": datetime,
            "status": "new",
            "aspectedby": ""
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<List> getservice(String number) async {
    try {
      var response = await http.post(Uri.parse(getservicelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'number': number}));
      return jsonDecode(utf8.decode(response.bodyBytes))['message'] as List;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> updateservice(
      String number,
      String cat,
      String lats,
      String lons,
      String late,
      String lone,
      String adds,
      String adde,
      String dis,
      String ride,
      String price,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatedservicelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "cat": cat,
            "lats": lats,
            "lons": lons,
            "late": late,
            "lone": lone,
            "adds": adds,
            "adde": adde,
            "dis": dis,
            "ride": ride,
            "price": price,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'tryagainlater');
      return false;
    }
  }

  static Future<bool> updatestatus(
      String id, String status, BuildContext context) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(updatestatuslink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
            "status": status,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      hideprogress(context);
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> updatedmenurating(
      String id, double itemrating, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(updatedmenuratinglink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id, "itemrating": itemrating}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      show_snackbar(context, 'try again later');
      return false;
    }
  }

  static Future<bool> deleteservice(String id, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(deleteservicelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      show_snackbar(context, data['sucess']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'tryagainlater');
      return false;
    }
  }

  // login
  static Future<bool> registration(
      String number,
      String firstname,
      String lastname,
      String gender,
      String pass,
      String email,
      String bikenumber,
      String licencenumber,
      String dob,
      String cat,
      String deviceid,
      BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(registrationlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "firstname": firstname,
            "lastname": lastname,
            "gender": gender,
            "pass": pass,
            "email": email,
            "bikenumber": bikenumber,
            "licencenumber": licencenumber,
            "dob": dob,
            "cat": cat,
            "deviceid": deviceid,
            "itemrating": "0",
            "itemuser": "0"
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<Map> login(
      String number, String pass, String deviceid, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(loginlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"number": number, "pass": pass, "deviceid": deviceid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(data['token']);
        return decodedToken['user'];
      } else {
        hideprogress(context);
        show_snackbar(context, data['message']);
        return {};
      }
    } catch (e) {
      hideprogress(context);
      show_snackbar(context, 'tryagainlater');
      return {};
    }
  }

  static Future<void> getuser() async {
    try {
      var response = await http.post(Uri.parse(getuserlink),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes))['data'] as List;
      for (var element in data) {
        FirebaseHelper.sendnotificationto(
            element['deviceid'], "New route", "Let's take the route");
      }
    } catch (e) {}
  }

  static Future<Map> getoneuser(String id) async {
    try {
      var response = await http.post(Uri.parse(getoneuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"id": id}));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (data['status']) {
        return data['data'] as Map;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updateuser(
    String number,
    String firstname,
    String lastname,
    String bikenumber,
    String licencenumber,
  ) async {
    try {
      var response = await http.post(Uri.parse(updateuserlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "firstname": firstname,
            "lastname": lastname,
            "bikenumber": bikenumber,
            "licencenumber": licencenumber,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> forgetpassword(
      String number,
      String password,
      String email,
      BuildContext context
      ) async {
    try {
      displayprogress(context);
      var response = await http.post(Uri.parse(forgetpasswordlink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number": number,
            "password": password,
            "email": email,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      hideprogress(context);
      show_snackbar(context, data['message']);
      return data['status'] as bool;
    } catch (e) {
      hideprogress(context);
      return false;
    }
  }
}
