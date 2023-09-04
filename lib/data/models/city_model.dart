class City {
  final int number;
  final String id;
  final String name;

  City({
    required this.number,
    required this.id,
    required this.name,
  });

  static List<City> cityList = [
    City(number: 1, id: 'istanbul', name: 'Стамбул'),
    City(number: 2, id: 'bursa', name: 'Бурса'),
    City(number: 3, id: 'antalya', name: 'Анталья'),
    City(number: 4, id: 'izmir', name: 'Измир'),
    City(number: 5, id: 'trabzon', name: 'Трабзон'),
    City(number: 6, id: 'canakkale', name: 'Чанаккале'),
    City(number: 7, id: 'amasya', name: 'Амасья'),
    City(number: 8, id: 'yalova', name: 'Ялова'),
    City(number: 9, id: 'denizle', name: 'Денизле'),
    City(number: 10, id: 'eshilova', name: 'Эшилова'),
    City(number: 11, id: 'hakkari', name: 'Хаккари'),
    City(number: 12, id: 'kutahya', name: 'Кютахья'),
    City(number: 13, id: 'mersin', name: 'Мерсин'),
    City(number: 14, id: 'rize', name: 'Ризе'),
  ];
}
