// lib/src/geofence_callback.dart

import 'package:geofence_foreground_service/constants/geofence_event_type.dart';
import 'package:geofence_foreground_service/geofence_foreground_service.dart';

/// [callbackDispatcher] is an entry-point function for the background callback
/// triggered by [GeofenceForegroundService].
///
/// It uses [GeofenceForegroundService] to handle triggers in the background.
@pragma('vm:entry-point')
void callbackDispatcher() async {
  // Use GeofenceForegroundService to handle triggers in the background
  GeofenceForegroundService().handleTrigger(
    backgroundTriggerHandler: (zoneID, triggerType) async {
      // Print information about the geofence event
      print('Geofence event: $triggerType');
      print(
          'Geofence event: $triggerType for zone $zoneID at ${DateTime.now()}');

      // Handle different geofence event types (enter/exit/dwell)
      switch (triggerType) {
        case GeofenceEventType.enter:
          // Perform actions upon entering the geofence zone (e.g., show notification)
          print('Entered zone $zoneID');
          break;
        case GeofenceEventType.exit:
          // Perform actions upon exiting the geofence zone (e.g., stop notification)
          print('Exited zone $zoneID');
          break;
        case GeofenceEventType.dwell:
          // Perform actions if the user stays within the geofence for a specific duration
          print('Dwelling in zone $zoneID');
          break;
        default:
          // Handle unknown geofence event types
          print('Unknown geofence event type: $triggerType');
          break;
      }

      // Return a Future<bool> based on the success of handling the trigger.
      // It always returns true, indicating successful handling.
      return true;
    },
  );
}
