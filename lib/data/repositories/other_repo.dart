import 'package:admin_gm/data/models/other_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OtherRepository {
  final db = FirebaseFirestore.instance;

  Future<List<Other>> getOther(
      {required String otherId, required String otherCity}) async {
    List<Other> otherList = [];
    try {
      final data =
          await db.collection('other').doc(otherId).collection(otherCity).get();
      data.docs.forEach((element) {
        return otherList.add(Other.fromJson(element.data(), element.id));
      });
      return otherList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
      return otherList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> postOther({
    required String otherId,
    required String otherCity,
    required String city,
    required String description,
    required String location,
    required String name,
    required String note,
    required String photo,
    required List gallery,
  }) async {
    try {
      await db.collection('other').doc(otherId).collection(otherCity).add({
        'city': city,
        'description': description,
        'location': location,
        'name': name,
        'note': note,
        'photo': photo,
        'gallery': gallery
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteOther(
      {required String otherId,
      required String otherCity,
      required String objectId}) async {
    print({'otherId': objectId, 'otherCity': otherCity, 'objectId': objectId});
    try {
      final data =
          await db.collection('other').doc(otherId).collection(otherCity);
      data.doc(objectId).delete();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
