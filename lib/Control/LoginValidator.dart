import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Entity/UserProfile.dart';

UserProfile userProfile = new UserProfile();

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

/// Authenticates the user through google sign in
/// @return Success message
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  userProfile.setUserID(user.uid);
  userProfile.setUserMail(user.email);
  userProfile.setUserName(user.displayName);
  userProfile.setUserDisplay(user.photoUrl);

  if (userProfile.getUserName().contains(" ")) {
    String name = userProfile
        .getUserName()
        .substring(0, userProfile.getUserName().indexOf(" "));
    userProfile.setUserName(name);
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  print('signInWithGoogle succeeded: $user');
  print('signInWithGoogle succeeded: $user.uid');
  return 'signInWithGoogle succeeded: $user';
}

///Logs out the user through google sign out
void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
