import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/helper/permission_helper.dart';
import 'package:untitled2/module/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

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
                  PermissionsHelper.instance.requestStoragePermission();
                },
                child: const Text('File access'),
              ),
              const SizedBox(height: 10),
              Text('LAT: ${controller.lat}' ?? ''),
              const SizedBox(height: 10),
              Text('LNG: ${controller.long}' ?? ''),
              const SizedBox(height: 10),
              Text('ADDRESS: ${controller.marks?[0].country}' ?? ''),
              Text('name: ${controller.marks?[0].name}' ?? ''),
              Text('street: ${controller.marks?[0].street}' ?? ''),
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
