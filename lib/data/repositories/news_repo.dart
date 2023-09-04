import 'package:admin_gm/data/models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NewsRepository {
  final db = FirebaseFirestore.instance;

  Future<List<News>> getNews() async {
    List<News> newsList = [];
    try {
      final data =
          await db.collection('news').orderBy('times', descending: true).get();
      data.docs.forEach((element) {
        return newsList.add(News.fromJson(element.data(), element.id));
      });
      return newsList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
      return newsList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> postNews(
      {required String t,
      required String cat,
      required String d1,
      required String img,
      required DateTime times}) async {
    try {
      await db.collection('news').add({
        't': t,
        'cat': cat,
        'img': img,
        'd1': d1,
        'times': times,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteNews({required String id}) async {
    try {
      final data = await db.collection('news');
      data.doc(id).delete();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
