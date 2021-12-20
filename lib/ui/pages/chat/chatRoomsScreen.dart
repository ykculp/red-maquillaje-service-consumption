// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:misiontic_template/domain/use_case/controllers/ui.dart';
// import 'package:misiontic_template/helper/constants.dart';
// import 'package:misiontic_template/helper/helpperfunctions.dart';
// import 'package:misiontic_template/ui/pages/chat/messages/search1.dart';
// import 'package:misiontic_template/ui/widgets/appbar.dart';

// class ChatRoom extends StatefulWidget {
//   const ChatRoom({Key? key}) : super(key: key);

//   @override
//   _ChatRoomState createState() => _ChatRoomState();
// }

// class _ChatRoomState extends State<ChatRoom> {
//   late final UIController uiController = Get.find();

//   @override
//   void initState() {
//     getUserInfo();
//     super.initState();
//   }

//   getUserInfo() async {
//     Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const SearchScreen()));
//         },
//         child: const Icon(Icons.search),
//       ),
//     );
//   }
// }
