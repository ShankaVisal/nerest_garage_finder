import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:meta/meta.dart';

part 'search_garage_event.dart';
part 'search_garage_state.dart';

class SearchGarageBloc extends Bloc<SearchGarageEvent, SearchGarageState> {
  SearchGarageBloc() : super(SearchGarageInitial()) {
    on<InitialEvent>(_initialEvent);
    on<NearestGarageSearchEvent>(_nearestGarageSearchEvent);
    on<CallToGarageEvent>(_callToGarageEvent);
  }

  FutureOr<void> _initialEvent(
      InitialEvent event, Emitter<SearchGarageState> emit) {
    emit(InitialState());
  }

  Future<void> _nearestGarageSearchEvent(
      NearestGarageSearchEvent event, Emitter<SearchGarageState> emit) async {
    try {
      emit(SearchInProgressState());

      // Load garage data
      List<dynamic> garages = await _loadGarageData();
      if (garages.isEmpty) {
        emit(SearchErrorState("No garages found in the database."));
        return;
      }

      // Get user location
      Position userLocation = await _determinePosition();

      // Find nearest garage
      Map<String, dynamic>? nearestGarage = _findNearestGarage(userLocation, garages);

      if (nearestGarage == null) {
        emit(SearchErrorState("No garage found near you."));
      } else {
        double distance = _calculateDistance(
            userLocation.latitude,
            userLocation.longitude,
            nearestGarage['latitude'],
            nearestGarage['longitude']);

        emit(SearchResultState(
            "Nearest Garage: ${nearestGarage['name']} (${distance.toStringAsFixed(2)} km away)"));
      }
    } catch (e) {
      emit(SearchErrorState("Error: ${e.toString()}"));
    }
  }

  Future<List<dynamic>> _loadGarageData() async {
    try {
      var garageList = GlobalConfiguration().getValue("garages");
      return garageList is List ? garageList : [];
    } catch (e) {
      return [];
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Earth radius in km
    double dLat = (lat2 - lat1) * pi / 180;
    double dLon = (lon2 - lon1) * pi / 180;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in km
  }

  Map<String, dynamic>? _findNearestGarage(Position userLocation, List<dynamic> garages) {
    double minDistance = double.infinity;
    Map<String, dynamic>? nearestGarage;

    for (var garage in garages) {
      double distance = _calculateDistance(userLocation.latitude,
          userLocation.longitude, garage["latitude"], garage["longitude"]);

      if (distance < minDistance) {
        minDistance = distance;
        nearestGarage = garage;
      }
    }

    return nearestGarage;
  }

  FutureOr<void> _callToGarageEvent(
      CallToGarageEvent event, Emitter<SearchGarageState> emit) {
    emit(CallToGarageState());
  }
}
