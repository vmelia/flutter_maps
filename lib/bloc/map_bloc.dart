import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

const _initialCameraPosition = CameraPosition(
  target: LatLng(50.3656, -4.1423),
  zoom: 11.5,
);

// Events.
@immutable
abstract class MapEvent {}

class ResetLocationEvent extends MapEvent {}

class SetControllerEvent extends MapEvent {
  final GoogleMapController mapController;

  SetControllerEvent(this.mapController);
}

// States.
@immutable
abstract class MapState {
  final initialCameraPosition = _initialCameraPosition;
}

class MapInitial extends MapState {}

class SetLocationState extends MapState {
  final CameraPosition cameraPosition;
  SetLocationState(this.cameraPosition);
}

// Bloc.
class MapBloc extends Bloc<MapEvent, MapState> {
  // ignore: unused_field
  GoogleMapController _mapController;

  MapBloc() : super(MapInitial());

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is SetControllerEvent) {
      _mapController = event.mapController;
    } else if (event is ResetLocationEvent) {
      //yield SetLocationState(initialCameraPosition);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
    }
  }
}
