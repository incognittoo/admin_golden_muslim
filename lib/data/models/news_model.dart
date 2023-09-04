import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class News {
  final String id;
  final String t;
  final String d1;
  final String img;
  final String cat;
  final DateTime? times;

  News({
    this.times,
    required this.id,
    required this.t,
    required this.d1,
    required this.img,
    required this.cat,
  });

  factory News.fromJson(Map<String, dynamic> json, String id) {
    try {
      return News(
          id: id,
          t: json['t'],
          d1: json['d1'],
          img: json['img'],
          cat: json['cat'],
          times: (json['times'] as Timestamp)
              .toDate() // Преобразование timestamp в DateTime
          );
    } catch (e) {
      print('Error creating News from JSON: $e');
      rethrow;
    }
  }

  formattedTime() {
    initializeDateFormatting('ru_RU', null); // проинициализировали локалы
    final formatter =
        DateFormat('dd MMMM yyyy', 'ru_RU'); // Формат даты и времени
    return formatter.format(times!);
  }
}
