import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map_bloc.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          myLocationButtonEnabled: false,
          initialCameraPosition: state.initialCameraPosition,
          onMapCreated: (controller) => context.read<MapBloc>().add(SetControllerEvent(controller)),
          markers: {
            if (mapBloc.origin != null) mapBloc.origin,
            if (mapBloc.destination != null) mapBloc.destination,
          },
          onLongPress: (position) => _addMarker(position, context),
        );
      },
    );
  }
}

_addMarker(LatLng position, BuildContext context) {
  final origin = BlocProvider.of<MapBloc>(context).origin;
  final destination = BlocProvider.of<MapBloc>(context).destination;

  if (origin == null || destination != null) {
    context.read<MapBloc>().add(SetOriginEvent(position));
  } else {
    context.read<MapBloc>().add(SetDestinationEvent(position));
  }
}
