import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';
import '../../auth/controllers/auth_controller.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController authController = Get.find();

  Stream<List<Message>> getMessages() {
    return _firestore.collection("messages").orderBy("timestamp", descending: true).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList(),
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    final user = authController.firebaseUser.value;
    if (user == null) return;

    final message = Message(
      sender: user.email!,
      text: text,
      timestamp: Timestamp.now(),
    );

    await _firestore.collection("messages").add(message.toJson());
  }
}