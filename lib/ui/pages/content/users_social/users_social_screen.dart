import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/models/user_social.dart';
import 'package:misiontic_template/domain/use_case/controllers/authentication.dart';
import 'package:misiontic_template/domain/use_case/controllers/connectivity.dart';
import 'package:misiontic_template/domain/use_case/social_management.dart';
import 'package:misiontic_template/ui/pages/content/chats/chat_screen.dart';
import 'package:misiontic_template/ui/pages/content/states/states_screen.dart';
import 'package:misiontic_template/ui/pages/content/users_social/widgets/new_publishSocial.dart';
import 'package:misiontic_template/ui/pages/content/users_social/widgets/social_card.dart';

class UsersSocialScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const UsersSocialScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<UsersSocialScreen> {
  late final SocialManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> publishStream;
  late ConnectivityController controller;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    manager = SocialManager();
    publishStream = manager.getPublishStream();
    controller = Get.find<ConnectivityController>();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: ElevatedButton(
              child: const Text("Agregar"),
              onPressed: () {
                // We don't allow to trigger the action if we don't have connectivity
                if (controller.connected) {
                  Get.dialog(
                    PublishSocial(
                      manager: manager,
                    ),
                  );
                } else {
                  Get.snackbar(
                    "Error de conectividad",
                    "No se encuentra conectado a internet.",
                  );
                }
              },
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: publishStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                final items = manager.extractPublish(snapshot.data!);
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    UserSocial publish = items[index];
                    return UserSocialCard(
                      title: publish.name,
                      content: publish.message,
                      picUrl: publish.picUrl,
                      onChat: () {
                        // Get.to(const UserMessages());
                      },
                      onTap: () {
                        // If the offer email is the same as the current user,
                        // we know that the user is the owner of that offer.
                        if (publish.email ==
                            authController.currentUser?.email) {
                          Get.dialog(
                            PublishSocial(
                              manager: manager,
                              userJob: publish,
                            ),
                          );
                        } else {
                          Get.snackbar(
                            "No Autorizado",
                            "No puedes editar esta publicación debido a que fue enviada por otro usuario.",
                          );
                        }
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Something went wrong: ${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
