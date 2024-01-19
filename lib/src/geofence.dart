// lib/src/geofence.dart

import 'dart:async';

import 'package:geofence_foreground_service/exports.dart';
import 'package:geofence_foreground_service/geofence_foreground_service.dart';
import 'package:geofence_foreground_service/models/zone.dart'; // Import the Zone class

import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Represents a geofence zone for monitoring location changes.
class MyGeofenceZone {
  final String id;
  final double latitude;
  final double longitude;
  final double radius;

  /// Constructor to create a geofence zone with specified parameters.
  MyGeofenceZone(
    this.id,
    this.latitude,
    this.longitude,
    this.radius,
  );

  /// Gets the observer token.
  get observerToken => null;

  /// Initializes the geofence zone.
  static Future<void> initialize() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      print('Geofence setup completed. Ready to monitor.');

      final Position position = await Geolocator.getCurrentPosition();
      final MyGeofenceZone zone = MyGeofenceZone('zone#1_id', position.latitude,
          position.longitude, 100.0 // Change this to your desired radius
          );

      try {
        await GeofenceForegroundService().addGeofenceZone(
          zone: Zone(
            id: zone.id,
            radius: zone.latitude,
            coordinates: [],
          ),
        );
        //To add a code to start monitoring location changes or implement other geofence-related logic here.
      } on Exception catch (error) {
        print('Error adding geofence: $error');
      }
    } else {
      print('Location service is disabled. Geofence functionality disabled.');
    }
  }

  /// Listens to the accelerometer sensor and handles accelerometer data.
  // Function to listen to accelerometer sensor
  void startAccelerometerListener() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      // Handle accelerometer data
      print('Accelerometer: $event');
    });
  }

  /// Listens to the user's location changes using the geolocator package.
  // Function to listen to user's location changes
  void startLocationListener() {
    // Use geolocator package to listen to location changes
    /// Starts continuous location updates.
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Stream<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings);

    positionStream.listen((Position position) {
      // Handle each location update here
      print(position.latitude);
      print(position.longitude);
    });
  }

  // Method for continuous location updates
  static StreamSubscription<Position> startLocationUpdates(
      Function(Position) callback) {
    return Geolocator.getPositionStream().listen(callback);
  }

  /// Adds a geofence zone with specified coordinates and radius.
  // New method to add a geofence zone
  static Future<void> addGeofenceZoneWithCoordinates(
    String id,
    double latitude,
    double longitude,
    double radius,
  ) async {
    try {
      await GeofenceForegroundService().addGeofenceZone(
        zone: Zone(
          id: id,
          radius: radius,
          coordinates: [LatLng(latitude, longitude)], // Use LatLng here
        ),
      );
    } catch (e) {
      print('Error adding geofence: $e');
    }
  }

  /// Edits a geofence.
//Editing function
  Future<void> editGeofence({required String observerToken}) async {
    // Implement editing logic
    if (await authenticateObserver(observerToken)) {
      print('Observer is authorized. Editing geofence...');
    } else {
      print('Observer is not authorized to edit geofence.');
    }
  }

  /// Deletes a geofence.
  //Deleting function
  Future<void> deleteGeofence({required String observerToken}) async {
    // Implement deletion logic
  }

  /// Lists all geofences.
//Listing Geofence function
  Future<List<MyGeofenceZone>> listGeofences() async {
    // Implement listing logic and return a list of geofences
    return [];
  }

  /// Authenticates the observer.
  authenticateObserver(observerToken) {}

  // LocationOptions({required LocationAccuracy accuracy, required int distanceFilter}) {}
}
