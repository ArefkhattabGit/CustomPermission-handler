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

  void requestMicPermission() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.microphone.request().isGranted) {
        print("Permission was granted");
      } else {
        buildDialog();
      }
    }
  }

  void requestPhonePermission() async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.phone.request().isGranted) {
        print("Permission was granted");
      } else {
        buildDialog();
      }
    }
  }

  void requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        print("Permission was granted");
      } else {
        buildDialog();
      }
    }
  }

  void requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.storage.request().isGranted) {
        print("Permission was granted");
      } else {
        buildDialog();
      }
    }
  }

  void requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      await getCurrentLocation();
      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        print("Permission was granted");
        await getCurrentLocation();
      } else {
        buildDialog();
      }
    }
  }

  void requestCalenderPermission() async {
    var status = await Permission.calendar.status;
    if (status.isGranted) {
      await openDatePicker();

      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.calendar.request().isGranted) {
        print("Permission was granted");
        await openDatePicker();
      } else {
        buildDialog();
      }
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
                    child: const Text('Calender')),
                ElevatedButton(
                    onPressed: () {
                      requestCameraPermission();
                      // requestCameraPermission();
                    },
                    child: const Text('Camera')),
                ElevatedButton(
                    onPressed: () {
                      requestPhonePermission();
                    },
                    child: const Text('Phone')),
                ElevatedButton(
                    onPressed: () {
                      requestMicPermission();
                    },
                    child: const Text('Microphone'))
              ]),
        ),
      ),
    );
  }

  void buildDialog() => WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("permission"),
            content: Text(
                "You will not be able to use this feature without enabling it now?"),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("settings"),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}
