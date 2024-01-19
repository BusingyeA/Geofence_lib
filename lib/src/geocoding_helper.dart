// lib/src/geocoding_helper.dart

import 'package:geocoding/geocoding.dart'; // Package for geocoding and reverse geocoding
import 'package:geolocator/geolocator.dart'; // Package for accessing device location

/// [GeocodingHelper] provides methods for geocoding and reverse geocoding.
/// [GeocodingHelper] provides methods for geocoding and reverse geocoding.
class GeocodingHelper {
  /// **Interacts with hardware:**
  ///
  /// Uses Geolocator package to access the device's GPS sensor for the current position.
  ///
  /// Returns a human-readable address based on the current device location.
  static Future<String?> getAddressFromCurrentLocation() async {
    try {
      // Get current device position using Geolocator
      Position currentPosition =
          await Geolocator.getCurrentPosition(); // Hardware interaction

      // Retrieve placemarks based on current coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );

      // Extract address information from the first placemark
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return '${placemark.name}, ${placemark.locality}, ${placemark.country}';
      }
    } catch (e) {
      // Handle any errors that occur during geocoding
      print('Error during geocoding: $e');
    }
    return null;
  }

  /// **No direct hardware interaction:**
  ///
  /// Uses Geocoding package to convert coordinates to an address (online service).
  ///
  /// Returns a human-readable address based on the provided coordinates.
  static Future<String?> getAddressFromCurrentPosition(
      double latitude, double longitude) async {
    try {
      // Get placemarks based on provided coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Extract address information from the first placemark
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return '${placemark.name}, ${placemark.locality}, ${placemark.country}';
      }
    } catch (e) {
      // Handle any errors that occur during geocoding
      print('Error during geocoding: $e');
    }
    return null;
  }

  /// **No direct hardware interaction:**
  ///
  /// Uses Geocoding package to convert an address to coordinates (online service).
  ///
  /// Returns a map containing latitude and longitude based on the provided address.
  static Future<Map<String, double>?> getCoordinates(String address) async {
    try {
      // Get locations based on provided address
      List<Location> locations = await locationFromAddress(address);

      // Extract coordinates from the first location
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return {'latitude': location.latitude, 'longitude': location.longitude};
      }
    } catch (e) {
      // Handle any errors that occur during reverse geocoding
      print('Error during reverse geocoding: $e');
    }
    return null;
  }
}
