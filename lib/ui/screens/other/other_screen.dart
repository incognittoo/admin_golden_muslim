import 'package:admin_gm/data/models/city_model.dart';
import 'package:admin_gm/data/models/other_list_model.dart';
import 'package:admin_gm/ui/widgets/other/other_list_cart_widget.dart';
import 'package:flutter/material.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  City selectedCity = City.cityList[0];

  void selectCity(City city) {
    setState(() {
      selectedCity = city;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ModalCity(onSelectCity: selectCity, selectedCity: selectedCity),
          Expanded(
            child: ListView.builder(
              itemCount: OtherList.otherList.length,
              itemBuilder: (BuildContext context, int index) {
                return OtherListCart(
                    otherList: OtherList.otherList[index],
                    selectedCity: selectedCity);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ModalCity extends StatelessWidget {
  final City? selectedCity;
  final Function(City) onSelectCity;

  const ModalCity({
    Key? key,
    required this.selectedCity,
    required this.onSelectCity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                child: ListView.builder(
                  itemCount: City.cityList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CityList(
                        city: City.cityList[index],
                        isSelected: City.cityList[index] == selectedCity,
                        onTap: () {
                          onSelectCity(City.cityList[index]);
                        });
                  },
                ),
              );
            },
          );
        },
        child: Text('${selectedCity?.name}'));
  }
}

class CityList extends StatelessWidget {
  final City city;
  final bool isSelected;
  final VoidCallback onTap;
  const CityList(
      {required this.city,
      super.key,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(onTap: onTap, child: Text(city.name)),
        ),
      ),
    );
  }
}
