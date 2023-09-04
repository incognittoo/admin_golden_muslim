import 'package:admin_gm/data/models/news_model.dart';
import 'package:admin_gm/data/models/other_list_model.dart';
import 'package:admin_gm/data/models/other_model.dart';
import 'package:flutter/material.dart';

class OtherCart extends StatelessWidget {
  final Other other;
  const OtherCart({required this.other, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/news_details', arguments: other);
      },
      child: SizedBox(
        height: 210,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(other.photo),
                fit: BoxFit.cover,
              )),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                other.name,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
