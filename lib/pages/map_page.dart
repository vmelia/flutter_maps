import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_maps/bloc/map_bloc.dart';
import 'package:flutter_maps/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          context.read<MapBloc>().add(ResetCameraPositionEvent());
        },
        child: Icon(Icons.center_focus_strong),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
