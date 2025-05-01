import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> updateUser(String name) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: name);
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
