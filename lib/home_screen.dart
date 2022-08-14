import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? lat;

  double? long;

  List<Placemark>? placemarks;

  getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks?[0].country);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });

    print(lat);
    print(long);
  }

  void requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // not requested yet
      await Permission.storage.request();
    } else {
      print('Permission isGranted ');
    }

    if (!status.isDenied) {
      // not requested yet
      await Permission.storage.request();
    } else {
      print('Permission isDenied');
    }
    if (status.isPermanentlyDenied) {
      print('to use storage this feature granted permission ');
    }
    if (!status.isPermanentlyDenied) {
      // not requested yet
      await Permission.storage.request();
    }
  }

  requestLocationPermission() async {
    var locationStatus = await Permission.location.status;

    if (locationStatus.isGranted) {
      print('Granted');

      // here get current location
      getCurrentLocation();
    }
    if (locationStatus.isPermanentlyDenied) {
      print('to use location this feature granted permission ');
    }
    if (locationStatus.isDenied) {
      //noting

      print('notGranted yet ');
      await Permission.location.request();
    }
  }

  requestCalenderPermission() async {
    var calenderState = await Permission.calendar.status;

    if (calenderState.isGranted) {
      print('Granted');

      // here get current location
      openDatePicker();
    }
    if (calenderState.isPermanentlyDenied) {
      print('to use location this feature granted permission ');
    }
    if (calenderState.isDenied) {
      //noting

      print('notGranted yet ');
      await Permission.calendar.request();
    }
  }

  openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        requestStoragePermission();
                      });
                    },
                    child: const Text('File access')),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      requestLocationPermission();
                    },
                    child: const Text('location')),
                SizedBox(
                  height: 10,
                ),
                Text('LAT: $lat' ?? '',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text('LNG: $long' ?? '',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text('ADDRESS: ${placemarks?[0].country}' ?? '',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      requestCalenderPermission();
                    },
                    child: const Text('Calender'))
              ]),
        ),
      ),
    );
  }
}
