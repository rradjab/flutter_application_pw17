import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/github_sign.dart';

class FireStoreAuthService extends StateNotifier<String> {
  FireStoreAuthService() : super('');

  void checkIfUserExists(String email, WidgetRef ref) async {
    try {
      final signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      state = '${signInMethods.isEmpty ? 'not-' : ''}exists';
    } on FirebaseAuthException catch (e) {
      state = e.code;
    } catch (e) {
      state = e.toString().contains('No element') ? 'not-exists' : e.toString();
    }
  }

  void signInWithGitHub(BuildContext context, WidgetRef ref) async {
    try {
      final result = await gitHubSignIn.signIn(context);

      final githubAuthCredential = GithubAuthProvider.credential(result.token!);

      await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);

      await FirebaseFirestore.instance.collection("users").doc().set({
        "userName": FirebaseAuth.instance.currentUser!.displayName!,
        "userEmail": FirebaseAuth.instance.currentUser!.email!,
      });
    } catch (e) {
      state = e.toString();
    }
    state = 'ok';
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
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        result.user!.updateDisplayName(username);
      }
    } on FirebaseAuthException catch (e) {
      state = e.code;
    } catch (e) {
      state = e.toString();
    }
    state = 'ok';
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
