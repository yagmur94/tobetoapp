import 'package:tobetoapp/constants/collection_names.dart';
import 'package:tobetoapp/models/catalog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Catalog>> getCatalog({
    String? category,
    String? level,
    String? subject,
    String? language,
    String? instructor,
    String? certificationStatus,
    String? status,
    bool? isFree,
  }) async {
    Query catalogQuery = _firebaseFirestore.collection(Collections.catalog);

    if (category != null) {
      catalogQuery = catalogQuery.where('category', isEqualTo: category);
    }
    if (level != null) {
      catalogQuery = catalogQuery.where('level', isEqualTo: level);
    }
    if (subject != null) {
      catalogQuery = catalogQuery.where('subject', isEqualTo: subject);
    }
    if (language != null) {
      catalogQuery = catalogQuery.where('language', isEqualTo: language);
    }
    if (instructor != null) {
      catalogQuery = catalogQuery.where('instructor', isEqualTo: instructor);
    }
    if (certificationStatus != null) {
      catalogQuery = catalogQuery.where('certificationStatus', isEqualTo: certificationStatus);
    }
    if (status != null) {
      catalogQuery = catalogQuery.where('status', isEqualTo: status);
    }
    if (isFree != null) {
      catalogQuery = catalogQuery.where('isFree', isEqualTo: isFree);
    }

    QuerySnapshot catalogs = await catalogQuery.get();

    return _mapCatalogs(catalogs);
  }
List<Catalog> _mapCatalogs(QuerySnapshot catalogs) {
  return catalogs.docs.map((DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Catalog.fromMap(
      {
        'id': doc.id,
        'title': data['title'],
        'instructor': data['instructor'],
        'category': data['category'],
        'level': data['level'],
        'subject': data['subject'],
        'language': data['language'],
        'certificationStatus': data['certificationStatus'],
        'status': data['status'],
        'imageUrl': data['imageUrl'],
        'rating': data['rating'],
      },
    );
  }).toList();
}
}
