import 'package:permission_handler/permission_handler.dart';

/// Requests location permission using the [Permission.location] type.
///
/// Returns a [Future<bool>] indicating whether the permission is granted.
Future<bool> requestLocationPermission(MockPermission mockPermission) async {
  var status = await Permission.location.request();
  return status.isGranted;
}

/// MockPermission class that is not being used elsewhere.
class MockPermission {}

/// Function to request notification permission.
///
/// Returns a [Future<bool>] indicating whether the notification permission is granted.
Future<bool> requestNotificationPermission() async {
  var status = await Permission.notification.request();
  return status.isGranted;
}

/// Function to request notification permission to observe.
///
/// Returns a [Future<bool>] indicating whether the access to notification policy is granted.
Future<bool> requestNotificationPermissiontoObserve() async {
  var observe = await Permission.accessNotificationPolicy.request();
  return observe.isGranted;
}
