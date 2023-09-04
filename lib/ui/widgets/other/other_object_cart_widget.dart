import 'package:admin_gm/data/models/other_model.dart';
import 'package:flutter/material.dart';

class OtherObjectCart extends StatelessWidget {
  final Map<String, dynamic> arg;
  final Other other;
  const OtherObjectCart({super.key, required this.arg, required this.other});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/other_objects_details', arguments: {
          'other': other,
          'arg': arg,
        });
      },
      child: SizedBox(
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(other.photo), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  other.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
