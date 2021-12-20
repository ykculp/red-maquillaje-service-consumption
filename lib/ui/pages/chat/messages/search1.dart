// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:misiontic_template/data/services/database.dart';
// import 'package:misiontic_template/helper/constants.dart';
// import 'package:misiontic_template/ui/pages/chat/messages/conversation_screen.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   DatabaseMethods databaseMethods = DatabaseMethods();
//   final searchTextEditingController = TextEditingController();

//   QuerySnapshot<Map<String, dynamic>>? searchSnapshot;

//   initiateSearch() {
//     databaseMethods
//         .getUserByUsername(searchTextEditingController.text)
//         .then((val) {
//       setState(() {
//         searchSnapshot = val;
//       });
//     });
//   }

//   Widget searchList() {
//     return searchSnapshot != null
//         ? ListView.builder(
//             itemCount: searchSnapshot?.docs.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return SearchTile(
//                 userName: (searchSnapshot?.docs[index].data())!['name'],
//                 userEmail: (searchSnapshot?.docs[index].data())!['email'],
//               );
//             },
//           )
//         : Container();
//   }

//   //create chatroom, send user conversation screen, pushreplacement
//   createChatroomAndStartConversation(String userName) {
//     DatabaseMethods databaseMethods = DatabaseMethods();
//     print(Constants.myName);
//     if (userName != Constants.myName) {
//       String chatroomId = getChatRoomId(userName, Constants.myName);
//       List<String> users = [userName, Constants.myName];
//       Map<String, dynamic> charRoomMap = {
//         "users": users,
//         "chatroomId": chatroomId,
//       };
//       databaseMethods.createChatRoom(chatroomId, charRoomMap);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ConversationScreen(chatRoomId: chatroomId),
//           ));
//     } else {
//       print("No puedes enviar mensajes a ti mismo.");
//     }
//   }

//   Widget SearchTile({required String userName, required String userEmail}) {
//     return Container(
//       color: const Color(0xFFF8BBD0),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(userName, style: const TextStyle()),
//               Text(userEmail, style: const TextStyle()),
//             ],
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () {
//               createChatroomAndStartConversation(userName);
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               child: const Text(
//                 "Mensaje",
//                 style: TextStyle(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Container(
//             color: const Color(0xFFF8BBD0),
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: searchTextEditingController,
//                     decoration: const InputDecoration(
//                       hintText: "Buscar usuario...",
//                       hintStyle: TextStyle(color: Colors.white54),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     initiateSearch();
//                     // databaseMethods
//                     //     .getUserByUsername(searchTextEditingController.text)
//                     //     .then((val) {
//                     //   print(val.toString());
//                     // });
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     padding: const EdgeInsets.all(6.0),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0x0FFFFFFF),
//                           Color(0xFFF8BBD0),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(40.0),
//                     ),
//                     child: Image.asset("assets/images/search_white.png"),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           searchList()
//         ],
//       ),
//     );
//   }
// }

// getChatRoomId(String a, String b) {
//   if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//     // ignore: unnecessary_string_escapes
//     return "$b\_$a";
//   } else {
//     // ignore: unnecessary_string_escapes
//     return "$a\_b";
//   }
// }
