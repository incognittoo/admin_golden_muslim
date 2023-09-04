import 'package:admin_gm/bloc/other/other_bloc.dart';
import 'package:admin_gm/bloc/other/other_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherObjectDetailScreen extends StatelessWidget {
  const OtherObjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final other =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    void _deleteObject(context) {
      BlocProvider.of<OtherBloc>(context).add(OtherDeleteEvent(
        other['arg']['otherId'],
        other['arg']['otherCity'],
        other['other'].id,
      ));
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Image(image: NetworkImage(other['other'].photo)),
          TextButton(
            onPressed: () {
              _deleteObject(context);
              Navigator.of(context).pop();
            },
            child: Text(
              'Удалить объект',
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Text(other['other'].name),
                  Text(other['other'].description ?? ''),
                  const SizedBox(height: 10),
                  Text(other['other'].note ?? ''),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
