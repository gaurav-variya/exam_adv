import 'package:exam_adv/model/receipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService fireStoreService = FirestoreService._();

  var firestore = FirebaseFirestore.instance;
  String collectionName = "Receipe";

  Future<void> allFavRecipe({required ReceipeModel modal}) async {
    await firestore
        .collection(collectionName)
        .doc("${modal.id}")
        .set(modal.toMap);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchFavData() {
    return firestore.collection(collectionName).snapshots();
  }

  Future<void> deleteFav({required ReceipeModel modal}) {
    return firestore.collection(collectionName).doc('${modal.id}').delete();
  }
}
