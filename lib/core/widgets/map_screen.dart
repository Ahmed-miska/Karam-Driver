import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../theming/colors.dart';

/// A MapScreen that shows a full-screen Google Map with a fixed center marker.
/// The user pans the map to choose a location; when the camera stops moving,
/// the center location is updated. Pressing “حفظ الموقع” returns the chosen location.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Completer to manage the GoogleMapController.
  final Completer<GoogleMapController> _mapController = Completer();

  // Default location (Hillah, Babylon, Iraq).
  static const LatLng _defaultLocation = LatLng(32.48276901245117, 44.41946792602539);
  // Selected location is updated when the camera stops moving.
  LatLng _selectedLocation = _defaultLocation;
  // Flag to enable the Save button only after location is updated.
  bool _locationUpdated = false;
  // Store the latest camera position during map movement.
  CameraPosition? _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    // Get the user’s current location.
    _getUserLocation();
  }

  /// Requests location permissions and obtains the current position.
  Future<void> _getUserLocation() async {
    // Check if location services are enabled.
    if (!await Geolocator.isLocationServiceEnabled()) {
      debugPrint('Location services are disabled.');
      return;
    }

    // Check and request location permissions.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      return;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        debugPrint('Location permissions are denied.');
        return;
      }
    }

    // Get the current user position.
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    debugPrint(
        'User location obtained: ${currentLatLng.latitude}, ${currentLatLng.longitude}');

    // Animate the map camera to the user's location with zoom level 17.
    final controller = await _mapController.future;
    CameraPosition newCameraPosition =
    CameraPosition(target: currentLatLng, zoom: 17);
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));

    // Update the selected location.
    _updateLocation(currentLatLng);
  }

  /// Updates the selected location and enables the Save button.
  void _updateLocation(LatLng newLocation) {
    setState(() {
      _selectedLocation = newLocation;
      _locationUpdated = true;
    });
    debugPrint(
        'Location updated to: ${newLocation.latitude}, ${newLocation.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختر الموقع')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            const CameraPosition(target: _defaultLocation, zoom: 17),
            // No markers since we are using a static center icon.
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            // Update the current camera position as the user pans the map.
            onCameraMove: (CameraPosition position) {
              _currentCameraPosition = position;
            },
            // Once the camera movement stops, update the selected location.
            onCameraIdle: () {
              if (_currentCameraPosition != null) {
                _updateLocation(_currentCameraPosition!.target);
              }
            },
          ),
          // Overlay a static marker icon at the center of the screen.
          const Center(
            child:  Icon(Icons.location_on, size: 50, color: Colors.red),
          ),
          // "Save Location" button positioned near the bottom.
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.25,
            right: MediaQuery.of(context).size.width * 0.25,
            child: ElevatedButton(
              onPressed: _locationUpdated
                  ? () {
                // Return the chosen location when pressed.
                Navigator.pop(context, _selectedLocation);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _locationUpdated ? AppColors.main : Colors.grey,
              ),
              child: const Text('حفظ الموقع',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
