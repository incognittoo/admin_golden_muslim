class OtherList {
  final int number;
  final String id;
  final String name;

  OtherList({required this.number, required this.id, required this.name});

  static List<OtherList> otherList = [
    OtherList(number: 1, id: 'hospitals', name: 'Русскоязычные больницы'),
    OtherList(number: 2, id: 'migrationService', name: 'Миграционная служба'),
    OtherList(number: 3, id: 'consulate', name: 'Консульство'),
    OtherList(number: 4, id: 'nufus', name: 'Нюфюс'),
    OtherList(number: 5, id: 'park', name: 'Парки для шашлыков'),
    OtherList(number: 6, id: 'expedition', name: 'Пеший походы'),
    OtherList(number: 7, id: 'horse', name: 'Верховная езда'),
    OtherList(number: 8, id: 'fishing', name: 'Рыболовные места'),
    OtherList(number: 9, id: 'gym', name: 'Спортивные залы'),
    OtherList(number: 10, id: 'football', name: 'Футбольные поля'),
    // OtherList(number: 11, id: 'park', name: 'Вопросы - ответ'),
  ];
}
