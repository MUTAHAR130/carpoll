import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:rideshare/ui/common/apihelpers/apihelper.dart';
import 'package:rideshare/ui/common/app_colors.dart';
import 'package:rideshare/ui/common/uihelper/snakbar_helper.dart';
import 'package:rideshare/ui/views/chat/allchats/allchats_view.dart';
import 'package:rideshare/ui/views/chat/chating/chating_view.dart';
import 'package:rideshare/ui/views/editprofile/editprofile_view.dart';
import 'package:rideshare/ui/views/login/login_view.dart';
import 'package:rideshare/ui/views/wallet/wallet_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpref_service_service.dart';
import '../../common/apihelpers/firebsaeuploadhelper.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final sharedpref = locator<SharedprefServiceService>();

  TextEditingController loc = TextEditingController();
  TextEditingController currentloc = TextEditingController();
  TextEditingController selectedprice = TextEditingController();
  LatLng currentlatlan = const LatLng(24.860966, 66.990501);

  late GoogleMapController controller;
  CameraPosition current = const CameraPosition(
    target: LatLng(24.860966, 66.990501),
    zoom: 11,
  );

  String cfilter = "all";
  List filters = ["all", "new", "progress", "completed"];

  void currentgo(BuildContext context) {
    if (currentloc.text.isEmpty) {
      show_snackbar(context, "fill address in current location");
    } else {
      if (our.isEmpty) {
        getLocationFromAddress(currentloc.text, context, 'c');
      } else {
        bool c = false;
        Map d = {};
        for (var element in our) {
          if (element['l'] == 'c') {
            c = false;
            d = element;
            break;
          }
          c = true;
        }
        if (c) {
          getLocationFromAddress(currentloc.text, context, 'c');
        } else {
          removefromour(d['id']);
          removeMarker(d['id']);
          getLocationFromAddress(currentloc.text, context, 'c');
        }
      }
    }
  }

  void target(BuildContext context) {
    if (loc.text.isEmpty) {
      show_snackbar(context, "fill start and end address");
    } else {
      if (our.isEmpty) {
        getLocationFromAddress(loc.text, context, 't');
      } else {
        bool t = false;
        Map d2 = {};
        for (var element in our) {
          if (element['l'] == 't') {
            t = false;
            d2 = element;
            break;
          }
          t = true;
        }
        if (t) {
          getLocationFromAddress(loc.text, context, 't');
        } else {
          removefromour(d2['id']);
          removeMarker(d2['id']);
          getLocationFromAddress(loc.text, context, 't');
        }
      }
    }
  }

  Map<PolylineId, Polyline> polyines = {};
  Future<void> generatepolyline(
      double startLat, double startLng, double endLat, double endLng) async {
    PolylineId id = const PolylineId("poly");

    Polyline polyline = Polyline(
        polylineId: id,
        color: kcPrimaryColor,
        points: await ploypoints(startLat, startLng, endLat, endLng),
        width: 8);
    polyines[id] = polyline;
    notifyListeners();
  }

  Future<List<LatLng>> ploypoints(
      double lats, double lons, double late, double lone) async {
    List<LatLng> polylinecoordinates = [];
    polylinecoordinates.add(LatLng(lats, lons));
    polylinecoordinates.add(LatLng(late, lone));
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            lats < late ? lats : late,
            lons < lone ? lons : lone,
          ),
          northeast: LatLng(
            lats < late ? lats : late,
            lons < lone ? lons : lone,
          ),
        ),
        50.0, // padding, adjust as needed
      ),
    );
    // PolylinePoints polylinePoints = PolylinePoints();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     'AIzaSyC86DFq-Mxin1gwrVtIzPKvwbeMJcq7raY',
    //     PointLatLng(lats, lons),
    //     PointLatLng(late, lone),
    //     travelMode: TravelMode.driving);
    // if(result.points.isNotEmpty){
    //   result.points.forEach((point) {
    //     polylinecoordinates.add(LatLng(point.latitude, point.longitude));
    //   });
    // } else {
    //   print(result.errorMessage);
    // }
    return polylinecoordinates;
  }

  void removefromour(id) {
    our.removeWhere((map) => map['id'] == id);
  }

  List our = [];
  Set<Marker> markers = {};
  Future<void> getLocationFromAddress(
      String address, BuildContext context, String oloc) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        addMarker(LatLng(latitude, longitude), address, oloc);
      } else {
        show_snackbar(context, "Write complete address");
      }
    } catch (e) {
      show_snackbar(context, e.toString());
    }
  }

  void addMarker(LatLng latLng, String address, String oloc) {
    MarkerId markerId = MarkerId(DateTime.now().toString());
    markers.add(Marker(
      markerId: markerId,
      position: latLng,
      draggable: true,
      onTap: () {
        removeMarker(markerId);
      },
      infoWindow: InfoWindow(
        title: address,
      ),
    ));
    our.add({
      "l": oloc,
      "id": markerId,
      "lat": latLng.latitude,
      "lon": latLng.longitude
    });
    if (markers.length == 2) {
      Map d1 = {};
      Map d2 = {};
      for (var element in our) {
        if (element['l'] == 'c') {
          d1 = element;
        } else if (element['l'] == 't') {
          d2 = element;
        }
      }
      generatepolyline(d1['lat'], d1['lon'], d2['lat'], d2['lon']);
      calculateDistance(d1['lat'], d1['lon'], d2['lat'], d2['lon']);
    }
    notifyListeners();
    controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
  }

  void removeMarker(MarkerId markerId) {
    markers.removeWhere((marker) => marker.markerId == markerId);
    removefromour(markerId);
    polyines.clear();
    distance = '';
    distancedouble = 0.0;
    prices.clear();
    selectedprice.clear();
    notifyListeners();
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentlatlan = LatLng(position.latitude, -position.longitude);
    getAddressFromLatLng(currentlatlan.latitude, currentlatlan.longitude);
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(currentlatlan, 14.0),
    );
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address =
            "${placemark.name}, ${placemark.subThoroughfare}, ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}";
        currentloc.text = address;
        notifyListeners();
      }
    } catch (e) {}
  }

  void zoom() {
    controller.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }

  void zoomout() {
    controller.animateCamera(
      CameraUpdate.zoomOut(),
    );
  }

  PanelController panelController = PanelController();
  bool open = true;
  void panel() {
    if (panelController.isPanelClosed) {
      open = true;
    } else if (panelController.isPanelOpen) {
      open = false;
    }
    notifyListeners();
  }

  Future<void> first() async {
    await Permission.location.request();
    await Permission.notification.request();
    getLocation();
  }

  String distance = '';
  double distancedouble = 0.0;
  void calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    const earthRadius = 6371.0;
    final double dLat = _degreesToRadians(endLat - startLat);
    final double dLng = _degreesToRadians(endLng - startLng);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLat)) *
            cos(_degreesToRadians(endLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    distancedouble = earthRadius * c;
    distance = "Distance is : ${distancedouble.toStringAsFixed(2)} km";
    ride = 'bike';
    calculateTravelCost(false);
    notifyListeners();
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  List prices = [];
  void calculateTravelCost(bool isCar) {
    const bikeFuelEfficiency = 40.0;
    const carFuelEfficiency = 15.0;
    const fuelPricePerLiter = 280;
    double fuelEfficiency = isCar ? carFuelEfficiency : bikeFuelEfficiency;
    double fuelConsumed = distancedouble / fuelEfficiency;
    double cost = fuelConsumed * fuelPricePerLiter;
    prices = generatePriceVariations(cost * 10);
  }

  List<String> generatePriceVariations(double actualPrice) {
    double lowerPercentage = 0.1;
    double higherPercentage = 0.1;
    double lower1 = (1 - lowerPercentage) * actualPrice;
    double lower2 = (1 - lowerPercentage * 2) * actualPrice;
    double higher1 = (1 + higherPercentage) * actualPrice;
    double higher2 = (1 + higherPercentage * 2) * actualPrice;
    List<String> priceVariations = [
      lower2.toInt().toString(),
      lower1.toInt().toString(),
      actualPrice.toInt().toString(),
      higher1.toInt().toString(),
      higher2.toInt().toString()
    ];
    return priceVariations;
  }

  String ride = '';
  void selectride(String val) {
    ride = val;
    if (distancedouble != 0.0) {
      prices.clear();
      calculateTravelCost(ride == "car");
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> booking(BuildContext context) async {
    if (markers.length != 2) {
      show_snackbar(context, "Add Both starting and ending destination");
    } else if (ride == '') {
      show_snackbar(context, "Select Ride");
    } else if (selectedprice.text.isEmpty) {
      show_snackbar(context, "Select a Price");
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );

      if (picked == null) {
        show_snackbar(context, "Select Date");
      } else {
        final TimeOfDay? pickedt = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedt == null) {
          show_snackbar(context, "Select Time");
        } else {
          displayprogress(context);
          Map d1 = {};
          Map d2 = {};
          for (var element in our) {
            if (element['l'] == 'c') {
              d1 = element;
            } else if (element['l'] == 't') {
              d2 = element;
            }
          }
          bool check = await ApiHelper.registerservice(
              sharedpref.readString('number'),
              sharedpref.readString('cat'),
              d1['lat'].toString(),
              d1['lon'].toString(),
              d2['lat'].toString(),
              d2['lon'].toString(),
              currentloc.text,
              loc.text,
              distancedouble.toStringAsFixed(2),
              ride,
              selectedprice.text.toString(),
              "${picked.toString().substring(0, 10)} ${pickedt.toString().substring(10, 15)}",
              context);
          if (check) {
            show_snackbar(context, "register sucessfully");
            clearall();
            await FirebaseHelper.sendnotificationto(
                sharedpref.readString("deviceid"),
                "New route",
                "You have sucessfully added new route");
            await ApiHelper.getuser();
            hideprogress(context);
          } else {
            show_snackbar(context, "Try again later");
            hideprogress(context);
          }
        }
      }
    }
  }

  void clearall() {
    markers.clear();
    loc.clear();
    currentloc.clear();
    prices.clear();
    polyines.clear();
    distance = '';
    distancedouble = 0.0;
    ride = '';
    our.clear();
    selectedprice.clear();
    notifyListeners();
  }

  void updateroute(Map data) {
    clearall();
    LatLng latLngs =
        LatLng(double.parse(data['lats']), double.parse(data['lons']));
    LatLng latLnge =
        LatLng(double.parse(data['late']), double.parse(data['lone']));
    currentloc.text = data['adds'];
    loc.text = data['adde'];
    addMarker(latLngs, data['adds'], 'c');
    addMarker(latLnge, data['adde'], 't');
    panelController.close();
  }

  Future<void> aspect(
      String id, String status, BuildContext context, Map data) async {
    await ApiHelper.updatestatus(id, status, context);
    status = status == "progress" ? "accepted" : status;
    await FirebaseHelper.sendnotificationto(data['user']['deviceid'], "Ride",
        "your ride has been ${status} by ${sharedpref.readString('fname')}");
    notifyListeners();
  }

  double rating = 0.0;

  Future<void> addreview(BuildContext context, Map data) async {
    await ApiHelper.updatedmenurating(data['user']["_id"], rating, context);
    Navigator.pop(context);
  }

  Future<void> chat(String number) async {
    Map c =
        await ApiHelper.registerchat(sharedpref.readString('number'), number);
    if (c['status']) {
      _navigationService.navigateWithTransition(
          ChatingView(
            id: c['message'],
            did: c['did'],
          ),
          routeName: Routes.chatingView,
          transitionStyle: Transition.rightToLeft);
    }
  }

  Future<void> chats() async {
    _navigationService.navigateWithTransition(const AllchatsView(),
        routeName: Routes.allchatsView,
        transitionStyle: Transition.rightToLeft);
  }

  Future<void> editprofile() async {
    _navigationService.navigateWithTransition(const EditprofileView(),
        routeName: Routes.editprofileView,
        transitionStyle: Transition.rightToLeft);
  }

  bool filter = false;
  void updatefilter() {
    filter = !filter;
    notifyListeners();
  }

  void logout() {
    sharedpref.remove('deviceid');
    sharedpref.remove('fname');
    sharedpref.remove('lname');
    sharedpref.remove('number');
    sharedpref.remove('gender');
    sharedpref.remove('email');
    sharedpref.remove('bike');
    sharedpref.remove('lic');
    sharedpref.remove('dob');
    sharedpref.remove('auth');
    _navigationService.clearStackAndShow(Routes.loginView);
    _navigationService.replaceWithTransition(const LoginView(),
        routeName: Routes.loginView, transitionStyle: Transition.rightToLeft);
  }

  void wallet() {
    _navigationService.navigateWithTransition(const WalletView(),
        routeName: Routes.walletView, transitionStyle: Transition.rightToLeft);
  }
}
