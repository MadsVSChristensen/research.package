// //ALL FIREBASE FILES IS CODE FROM "THE NET NINJA" ON YOUTUBE.

// import 'package:firebase_auth/firebase_auth.dart';
// import 'user.dart';

// class FBAuth {

// final FirebaseAuth _auth = FirebaseAuth.instance;

// //pull desired stuff from firebase user.
// User _fbCustomUser(FirebaseUser user) {
//   return user != null ? User(uid: user.uid) : null;
// }

// //stream of authentication
// Stream<User> get fbuser {
//   return _auth.onAuthStateChanged.map(_fbCustomUser);
// }

// //anon sign-in
// Future anonSignIn() async {
//   try{
//     AuthResult response = await _auth.signInAnonymously();
//     FirebaseUser user = response.user;
//     return _fbCustomUser(user);
//   }catch (error) {
//     print(error.toString());
//     return null;
//   }

// }

// //sign-out
// Future signOut () async {
//   try {
//     return await _auth.signOut();
//   } catch (error) {
//     print(error.toString());
//     return null;
//   }
// }

// }
