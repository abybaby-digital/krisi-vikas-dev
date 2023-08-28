import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/chat/individual_chat_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import '../../widgets/all_widgets.dart';

class AllChatsListScreen extends StatefulWidget {
  const AllChatsListScreen({Key? key}) : super(key: key);

  @override
  _AllChatsListScreenState createState() => _AllChatsListScreenState();
}

class _AllChatsListScreenState extends State<AllChatsListScreen> {
  var chatRoomStream;

  getMyInfo() async {
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getDeviceToken();

    chatRoomStream = await FirebaseMethods().getChatRoom(
      SharedPreferencesFunctions.phoneNumber.toString(),
    );

    setState(
      () {},
    );
  }

  @override
  void initState() {    
    getMyInfo();
    super.initState();
  }

  Widget ChatRoomListTile(DocumentSnapshot dz) {
    String FilterChatHead = dz.data().toString();

    String numberOne  = dz.get("usersPhoneNumbers")[0];
    String numberTwo  = dz.get("usersPhoneNumbers")[1];
    String tokenOne  = dz.get("usersDeviceTokenIds")[0]?? "";
    String tokenTwo  = dz.get("usersDeviceTokenIds")[1]?? "";

    String userPhoneNumber =
        SharedPreferencesFunctions.phoneNumber ==numberOne
            ? numberTwo
            :numberOne;

    String userDeviceTokenIdId =
        SharedPreferencesFunctions.deviceToken == tokenOne
            ? tokenTwo
            : tokenOne;
    String lastMessage = FilterChatHead.contains('lastMessage') ? dz.get("lastMessage") ?? "" : "";
    String lastMessageTS = FilterChatHead.contains('lastMessageTime') ?  dz.get("lastMessageTime") ?? "" : "";

    return Container(
      child: ListTile(
        onTap: () {
          Map<String, dynamic> chatRoomInfoMap = {
            "usersPhoneNumbers": [
              SharedPreferencesFunctions.phoneNumber.toString(),
              userPhoneNumber,
            ],
            "usersDeviceTokenIds": [
              SharedPreferencesFunctions.deviceToken,
              userDeviceTokenIdId,
            ],
            "ts": DateTime.now()
          };
          goto(
            context,
            IndividualChatScreen(
              otherUserPhoneNumber: userPhoneNumber,
              otherUserDeviceTokenId: userDeviceTokenIdId,
              chatRoomInfoMap: chatRoomInfoMap,
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 7,
        ),

        leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
            child: Icon(
              Icons.person,
              color: white,
            )
            //  CachedNetworkImage(
            //   imageUrl: userImageUrl,
            //   fit: BoxFit.cover,
            //   placeholder: (context, url) => CircleAvatar(
            //     backgroundColor: Colors.teal[700],
            //     child: Icon(
            //       Icons.person,
            //       color: Colors.white,
            //       size: 40,
            //     ),
            //   ),
            //   errorWidget: (context, url, error) => CircleAvatar(
            //     backgroundColor: Colors.teal[700],
            //     child: Icon(
            //       Icons.error,
            //       color: Colors.white,
            //       size: 40,
            //     ),
            //   ),
            // ),
            ),
        // leading: userImageUrl != ""
        //     ? Container(
        //       width: 50,
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(50),
        //           child: Image.network(
        //             userImageUrl,
        //             fit: BoxFit.cover,
        //             width: 50,
        //             height: 50,
        //           ),
        //         ),
        //       )
        //     : Container(
        //        width: 50,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.teal[700],
        //           radius: 28,
        //           child: IconButton(
        //             icon: Icon(Icons.person,size: 30,),
        //             onPressed: (){

        //             },

        //           ),
        //         ),
        //       ),

        title: Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: barlowBold(
              text: userPhoneNumber.tr,
              size: 17,
              color: black,
            )),
        subtitle: barlowRegular(
          text: lastMessage.length > 20
              ? "${lastMessage.substring(0, 20)}..."
              : lastMessage,
          size: 17,
          color: grey,
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            barlowRegular(
              text: lastMessageTS,
              color: black,
              size: 15,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: chatRoomStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.length == 0
                    ? Center(
                        child: barlowRegular(
                          text: noChats.tr,
                          color: black,
                          size: 15,
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return ChatRoomListTile(ds);
                        },
                      )
                : Center(
                    child: progressIndicator(context),
                  );
          },
        ),
      ),
    );
  }
}
