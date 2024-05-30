import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobetoapp/constants/collection_names.dart';

class FirebaseFirestoreService {
  Future<List<String>> getCategories() async {
    List<String> categoriesList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(Collections.categories).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      var category = doc.data()['category'];
      if (category != null) {
        categoriesList.add(category as String);
      }
    }
    return categoriesList;
  }

  Future<List<String>> getCertificationStatuses() async {
    List<String> certificationStatusList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(Collections.certificationStatuses).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      var status = doc.data()['status'];
      if (status != null) {
        certificationStatusList.add(status as String);
      }
    }
    return certificationStatusList;
  }

  Future<List<String>> getInstructors() async {
    List<String> instructorsList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(Collections.instructors).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      var instructor = doc.data()['instructor'];
      if (instructor != null) {
        instructorsList.add(instructor as String);
      }
    }
    return instructorsList;
  }

  Future<List<String>> getLanguages() async {
    List<String> languagesList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(Collections.languages).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      var language = doc.data()['language'];
      if (language != null) {
        languagesList.add(language as String);
      }
    }
    return languagesList;
  }

  Future<List<String>> getLevels() async {
    List<String> levelsList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(Collections.levels).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      var level = doc.data()['level'];
      if (level != null) {
        levelsList.add(level as String);
      }
    }
    return levelsList;
  }

  Future<List<String>> getSubjects() async {
    List<String> subjectsList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(Collections.subjects).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      var subject = doc.data()['subject'];
      if (subject != null) {
        subjectsList.add(subject as String);
      }
    }
    return subjectsList;
  }
}
