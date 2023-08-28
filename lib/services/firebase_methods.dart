import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krishivikas/services/save_user_info.dart';

class FirebaseMethods {
  Future createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapshot.exists) {
      return true;
    } else {
      return await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  ///Read And Unread Method
  Future<Stream<QuerySnapshot>> getChatRoom(String myUserName) async {
    print(myUserName);
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where("usersPhoneNumbers", arrayContains: myUserName)
        .snapshots();
  }

  Future lastMessageUpdate(
      String chatRoomId,
      Map<String, dynamic> lastMessageInfoMap,
      Map<String, dynamic>? chatRoomInfoMap,
      otherUserDeviceTokenId) async {
    ///Data Get
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    Map<String, dynamic>? data = snapshot.data();
    var value = data?['usersDeviceTokenIds'];

    ///Shared Token
    await SharedPreferencesFunctions().getDeviceToken();
    if (SharedPreferencesFunctions.deviceToken != value[0] ||
        otherUserDeviceTokenId != value[1]) {
      return await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .update(chatRoomInfoMap!);
    }

    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }
}
