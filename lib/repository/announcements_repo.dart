import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tobetoapp/models/announcement_model.dart';


class AnnouncementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAnnouncement(Announcements announcement) async {
    await _firestore
        .collection('announcements')
        .doc(announcement.id)
        .set(announcement.toMap());
  }

  Future<void> deleteAnnouncement(String id) async {
    await _firestore.collection('announcements').doc(id).delete();
  }

  Stream<List<Announcements>> getAnnouncementsStream() {
    return _firestore
        .collection('announcements')
        .orderBy('createdAt', descending: false) // False diyerek en duyularin basta gozukmesini sagliyoruz.
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Announcements.fromMap(data);
      }).toList();
    });
  }
}

