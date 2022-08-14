import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:user_management_app/home/view/home_page.dart';
import 'package:user_management_app/sign_up/model/signup_model.dart';
import 'package:user_management_app/sign_up/view/utilities/utilities.dart';

class LoginProvider with ChangeNotifier {
  final userName = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  UserModel loggedUserModelH = UserModel();
  final password = TextEditingController();
  Stream<User?> stream() => auth.authStateChanges();
  onTabLoginFunction(
      BuildContext context, String emailFn, String passwordFn) async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(email: emailFn, password: passwordFn)
            .then(
              (value) => {
                getDataFromCloud(context),
              },
            );
      } on FirebaseAuthException catch (e) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            iconPositionLeft: 0,
            iconPositionTop: 0,
            iconRotationAngle: 0,
            icon: Icon(
              Icons.abc,
              color: kSwhite,
            ),
            message: e.message.toString(),
          ),
        );
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    await auth.signOut();
  }

  getDataFromCloud(BuildContext context) async {
    User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUserModelH = UserModel.fromMap(value.data()!);
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UserHomeScreen(),
          ),
          (route) => false);
    });
  }

  onTabGoogleFunction(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    final gauth = await account!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );
    final result = await auth.signInWithCredential(credential);
    return result.user;
  }

  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }
}
