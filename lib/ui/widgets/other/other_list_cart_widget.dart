import 'package:admin_gm/data/models/city_model.dart';
import 'package:admin_gm/data/models/other_list_model.dart';
import 'package:flutter/material.dart';

class OtherListCart extends StatelessWidget {
  final OtherList otherList;
  final City selectedCity;
  const OtherListCart(
      {required this.otherList, super.key, required this.selectedCity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/other_details',
            arguments: {'otherList': otherList, 'selectedCity': selectedCity});
      },
      child: Column(
        children: [
          ListTile(
            leading: ExcludeSemantics(
                child: CircleAvatar(
              child: Text(otherList.number.toString()),
            )),
            title: Text(otherList.name),
          ),
          Divider(
            color: Colors.grey,
            height: 5,
            thickness: 1,
            indent: 20,
          )
        ],
      ),
    );
  }
}
