// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geofence_p/export_files.dart';
import 'package:geofence_p/geofence_p.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GeofenceHomePageState(),
    );
  }
}

class GeofenceHomePageState extends StatefulWidget {
  const GeofenceHomePageState({super.key});

  @override
  _GeofenceHomePageState createState() => _GeofenceHomePageState();
}

class _GeofenceHomePageState extends State<GeofenceHomePageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geofencing Example App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                initializeGeofence();
                bool locationPermissionGranted =
                    await requestLocationPermission(MockPermission());
                bool notificationPermissionGranted =
                    await requestNotificationPermission();
                bool observePermissionGranted =
                    await requestNotificationPermissiontoObserve();

                print(
                    'Location Permission Granted: $locationPermissionGranted');
                print(
                    'Notification Permission Granted: $notificationPermissionGranted');
                print(
                    'Notification Observation Permission Granted: $observePermissionGranted');
              },
              child: const Text('Open Geofence Features'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                MyGeofenceZone myGeofenceZone = MyGeofenceZone(
                  'example_zone_id',
                  37.7749, // Example latitude
                  -122.4194, // Example longitude
                  100.0, // Example radius
                );

                await myGeofenceZone.editGeofence(
                    observerToken: 'example_observer_token');
              },
              child: const Text('Edit Geofence Zone'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                MyGeofenceZone myGeofenceZone = MyGeofenceZone(
                  'example_zone_id',
                  37.7749, // Example latitude
                  -122.4194, // Example longitude
                  100.0, // Example radius
                );

                StreamSubscription locationSubscription =
                    MyGeofenceZone.startLocationUpdates((position) {
                  print('Location Update: $position');
                });

                myGeofenceZone.startAccelerometerListener();
                myGeofenceZone.startLocationListener();

                await MyGeofenceZone.addGeofenceZoneWithCoordinates(
                  'custom_zone_id',
                  40.7128, // Example latitude
                  -74.0060, // Example longitude
                  200.0, // Example radius
                );

                await Future.delayed(const Duration(seconds: 30));
                locationSubscription.cancel();
              },
              child: const Text('Request to Observe Another User'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                MyGeofenceZone myGeofenceZone = MyGeofenceZone(
                  'example_zone_id',
                  37.7749, // Example latitude
                  -122.4194, // Example longitude
                  100.0, // Example radius
                );

                StreamSubscription locationSubscription =
                    MyGeofenceZone.startLocationUpdates((position) {
                  print('Location Update: $position');
                });

                myGeofenceZone.startAccelerometerListener();
                myGeofenceZone.startLocationListener();

                await MyGeofenceZone.addGeofenceZoneWithCoordinates(
                  'custom_zone_id',
                  40.7128, // Example latitude
                  -74.0060, // Example longitude
                  200.0, // Example radius
                );

                await Future.delayed(const Duration(seconds: 30));
                locationSubscription.cancel();
              },
              child: const Text('Observe Defined Geofence Zone'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                MyGeofenceZone myGeofenceZone = MyGeofenceZone(
                  'example_zone_id',
                  37.7749, // Example latitude
                  -122.4194, // Example longitude
                  100.0, // Example radius
                );

                await myGeofenceZone.deleteGeofence(
                    observerToken: 'example_observer_token');
              },
              child: const Text('Delete Zone'),
            ),
          ],
        ),
      ),
    );
  }
}
