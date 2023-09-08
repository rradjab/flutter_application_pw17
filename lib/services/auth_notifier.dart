import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/providers/providers.dart';

class FireStoreAuthService extends StateNotifier<String> {
  FireStoreAuthService() : super('');

  void switchUser() {
    state = '';
  }

  void checkIfUserExists(String email, WidgetRef ref) async {
    try {
      final signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.isEmpty) {
        state = 'not-exists';
      } else {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('userEmail', isEqualTo: email)
            .get();
        ref
            .read(usernameProvider.notifier)
            .update((state) => snapshot.docs.first['userName']);
        state = 'exists';
      }
    } on FirebaseAuthException catch (e) {
      state = e.code;
    } catch (e) {
      state = e.toString().contains('No element') ? 'not-exists' : e.toString();
    }
  }

  void loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      state = 'ok';
    } on FirebaseAuthException catch (e) {
      state = e.code;
    } catch (e) {
      state = e.toString();
    }
  }

  void createUser(String email, String password, String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection("users").doc().set({
        "userName": username,
        "userEmail": email,
      });
      state = 'ok';
    } on FirebaseAuthException catch (e) {
      state = e.code;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
