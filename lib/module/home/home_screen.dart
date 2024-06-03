import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled2/helper/permission_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _lat;
  double? _long;
  List<Placemark>? _placemarks;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {

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
      setState(() {
        _lat = position.latitude;
        _long = position.longitude;
        _placemarks = placemarks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  PermissionsHelper.instance
                      .requestStoragePermission(onGranted: () {});
                },
                child: const Text('File access'),
              ),
              const SizedBox(height: 10),
              Text('LAT: $_lat' ?? ''),
              const SizedBox(height: 10),
              Text('LNG: $_long' ?? ''),
              const SizedBox(height: 10),
              Text('ADDRESS: ${_placemarks?[0].country}' ?? ''),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  PermissionsHelper.instance.requestCalendarPermission();
                },
                child: const Text('Calendar'),
              ),
              ElevatedButton(
                onPressed: () {
                  PermissionsHelper.instance.requestCameraPermission();
                },
                child: const Text('Camera'),
              ),
              ElevatedButton(
                onPressed: () {
                  PermissionsHelper.instance.requestPhonePermission();
                },
                child: const Text('Phone'),
              ),
              ElevatedButton(
                onPressed: () {
                  PermissionsHelper.instance.requestMicrophonePermission();
                },
                child: const Text('Microphone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
