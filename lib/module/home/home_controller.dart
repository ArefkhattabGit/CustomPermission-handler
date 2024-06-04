import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:untitled2/helper/permission_helper.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  double? lat;
  double? long;
  List<Placemark>? marks;

  Future<void> getLocation() async {
    await PermissionsHelper.instance.requestLocationPermission(
        onGranted: () async {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      PermissionsHelper.instance.getCurrentLocation();

      update([
        lat = position.latitude,
        long = position.longitude,
        marks = placemarks
      ]);
    });
  }
}
