import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_configuration/global_configuration.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

var garage_list;
List<dynamic> garages = [];



Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

  Future<void> loadJsonDate() async {
  garage_list = await GlobalConfiguration().getValue("garages");
  garages = garage_list as List<dynamic>;
  print(garages);
  }

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double R = 6371; // Earth radius in km
  double dLat = (lat2 - lat1) * pi / 180;
  double dLon = (lon2 - lon1) * pi / 180;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
          sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c; // Distance in km
}

Map<String, dynamic>? findNearestGarage(Position userLocation) {
  double minDistance = double.infinity;
  Map<String, dynamic>? nearestGarage;

  for (var garage in garages) {
    double distance = calculateDistance(
        userLocation.latitude, userLocation.longitude,
        garage["latitude"], garage["longitude"]);

    if (distance < minDistance) {
      minDistance = distance;
      nearestGarage = garage;
    }
  }

  return nearestGarage;
}

void findGarage() async {
  try {
    Position userLocation = await _determinePosition();
    Map<String, dynamic>? nearestGarage = findNearestGarage(userLocation);

    if (nearestGarage != null) {
      print("Nearest Garage: ${nearestGarage['name']}");
      print("Distance for Nearst Garage: ${calculateDistance(userLocation.latitude, userLocation.longitude, nearestGarage['latitude'], nearestGarage['longitude'])} km");
    } else {
      print("No garage found.");
    }
  } catch (e) {
    print("Error: $e");
  }
}




@override
  initState() {
  super.initState();
  loadJsonDate();
  findGarage();
  // _determinePosition().then((Position position) {
  //   print('Location: ${position.latitude}, ${position.longitude}');
  // }).catchError((e) {
  //   print(e);
  // });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Garage Finder'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _determinePosition().then((Position position) {
              print('Location: ${position.latitude}, ${position.longitude}');
            }).catchError((e) {
              print(e);
            });
          },
          child: const Text('Find Nearest Garage'),
        ),
      ),
    );
  }
}