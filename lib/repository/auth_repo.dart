import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:tobetoapp/models/user_model.dart';

class AuthRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  // login user
  Future<User?> loggedInUser(String email, password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // create user
  Future<User?> signUp(String name, lastName, email, password) async {
    UserModel newUser = UserModel(
      name: name,
      lastName: lastName,
      email: email,
      role: 'student', // default olarak student kaydı yapılıyor.
    );
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await _db
            .collection("users")
            .doc(credential.user!.uid)
            .set(newUser.toMap());
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

   Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      // Kullanıcı Google hesabı seçmeden çıkış yaptı
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    if (userCredential.user != null) {
      final User user = userCredential.user!;
      final userDoc = await _db.collection("users").doc(user.uid).get();
      if (!userDoc.exists) {
        // Kullanıcı Firestore'da kayıtlı değilse yeni kayıt oluştur
        UserModel newUser = UserModel(
          name: googleUser.displayName ?? '',
          lastName: '',
          email: googleUser.email,
          role: 'student', // default olarak student kaydı yapılıyor.
        );
        await _db.collection("users").doc(user.uid).set(newUser.toMap());
      }
      return user;
    } else {
      return null;
    }
  }


  // get user role
  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    return doc['role'] as String;
  }

  // logout user
  Future<void> logout() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
