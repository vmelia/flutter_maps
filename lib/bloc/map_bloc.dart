import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

const _defaultTarget = LatLng(50.3656, -4.1423);
const _defaultZoom = 16.0;

// Events.
@immutable
abstract class MapEvent {}

class ResetCameraPositionEvent extends MapEvent {}

class SetControllerEvent extends MapEvent {
  final GoogleMapController mapController;
  SetControllerEvent(this.mapController);
}

class SetOriginEvent extends MapEvent {
  final LatLng value;
  SetOriginEvent(this.value);
}

class SetDestinationEvent extends MapEvent {
  final LatLng value;
  SetDestinationEvent(this.value);
}

// States.
@immutable
abstract class MapState {
  final initialCameraPosition = CameraPosition(
    target: _defaultTarget, // Plymouth.
    zoom: _defaultZoom,
  );
}

class MapInitial extends MapState {}

class MarkerChangedState extends MapState {}

// Bloc.
class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController _mapController;
  Marker origin;
  Marker destination;

  MapBloc() : super(MapInitial());

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is SetControllerEvent) {
      _mapController = event.mapController;
    } else if (event is ResetCameraPositionEvent) {
      var position = origin != null ? origin.position : _defaultTarget;
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: _defaultZoom)));
    } else if (event is SetOriginEvent) {
      origin = createMarker('origin', event.value, BitmapDescriptor.hueGreen);
      destination = null;
      yield MarkerChangedState();
    } else if (event is SetDestinationEvent) {
      destination = createMarker('destination', event.value, BitmapDescriptor.hueBlue);
      yield MarkerChangedState();
    }
  }
}

Marker createMarker(String id, LatLng value, double hue) {
  return Marker(
    markerId: MarkerId(id),
    infoWindow: InfoWindow(title: id),
    icon: BitmapDescriptor.defaultMarkerWithHue(hue),
    position: value,
  );
}
