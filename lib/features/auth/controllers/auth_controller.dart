import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../chat/screens/chat_screen.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => ChatScreen());
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  void logout() {
    _auth.signOut();
    Get.offAll(() => LoginScreen());
  }
}