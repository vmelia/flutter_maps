import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map_bloc.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          myLocationButtonEnabled: false,
          //zoomControlsEnabled: false,
          initialCameraPosition: state.initialCameraPosition,
          onMapCreated: (controller) => context.read<MapBloc>().add(SetControllerEvent(controller)),
        );
      },
    );
  }
}
