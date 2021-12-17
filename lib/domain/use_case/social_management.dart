import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:misiontic_template/data/repositories/firestore_database.dart';
import 'package:misiontic_template/domain/models/user_social.dart';

class SocialManager {
  final _database = FirestoreDatabase();

  Future<void> sendPublish(UserSocial publish) async {
    await _database.add(collectionPath: "Social", data: publish.toJson());
  }

  Future<void> updatePublish(UserSocial publish) async {
    await _database.updateDoc(documentPath: publish.dbRef!, data: publish.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPublishStream() {
    return _database.listenCollection(collectionPath: "Social");
  }

  Future<List<UserSocial>> getPublishOnce() async {
    final publishData = await _database.readCollection(collectionPath: "Social");
    return _extractInstances(publishData);
  }

  List<UserSocial> extractPublish(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final publishData = _database.extractDocs(snapshot);
    return _extractInstances(publishData);
  }

  Future<void> removePublish(UserSocial publish) async {
    await _database.deleteDoc(documentPath: publish.dbRef!);
  }

  List<UserSocial> _extractInstances(List<Map<String, dynamic>> data) {
    List<UserSocial> publish = [];
    for (var statusJson in data) {
      publish.add(UserSocial.fromJson(statusJson));
    }
    return publish;
  }
}
