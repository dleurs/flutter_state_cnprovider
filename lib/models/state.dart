import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:simple_flutter_auth_app/models/settings.dart';
import 'package:flutter_state_cnprovider/models/user.dart';
import 'package:flutter_state_cnprovider/services/database.dart';
import 'package:flutter_state_cnprovider/services/store-local.dart';

class StateModel extends ChangeNotifier {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  //Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
  }) {
    print("1. State model constructor, " + this.toString());
  }

  void setIsLoading(bool isLoadingInput) {
    this.isLoading = isLoadingInput;
    notifyListeners();
  }

  void updateStateModel(FirebaseUser firebaseUserAuthInput, User userInput) {
    this.firebaseUserAuth = firebaseUserAuthInput;
    this.user = userInput;
    notifyListeners();
  }

  // init
  Future<StateModel> initState() async {
    FirebaseUser firebaseUserAuth = await FirebaseAuth.instance.currentUser();
    User user = await StoreLocal().getUserLocal();
    this.updateStateModel(firebaseUserAuth, user);
    print("2. State model initialization, " + this.toString());
    return this;
  }

  Future<StateModel> signInAnonymous() async {
    FirebaseUser firebaseUser =
        (await FirebaseAuth.instance.signInAnonymously()).user;
    User user = User(uid: firebaseUser.uid, isAnonymous: true);
    await StoreLocal().storeUserLocal(user);
    await DatabaseService(uid: firebaseUser.uid).updateUserDataAnonymous();
    this.updateStateModel(firebaseUser, user);
    print("3. State model sign in anonymously, " + this.toString());
    return this;
  }

  // sign out
  Future signOut() async {
    await StoreLocal().deleteUserLocal();
    await FirebaseAuth.instance.signOut();
    this.updateStateModel(null, null);
  }

  String toString() {
    String res="";
    if (this.user != null) {
      res = "User.uid = " + this.user.uid;
    } else {
      res = "User null";
    }
    return res;
  }
}
