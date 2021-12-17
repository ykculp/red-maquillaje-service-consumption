import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/models/user_social.dart';
import 'package:misiontic_template/domain/models/user_status.dart';
import 'package:misiontic_template/domain/use_case/controllers/authentication.dart';
import 'package:misiontic_template/domain/use_case/social_management.dart';

class PublishSocial extends StatefulWidget {
  final SocialManager manager;
  final UserSocial? userJob;

  const PublishSocial({Key? key, required this.manager, this.userJob})
      : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<PublishSocial> {
  late AuthController controller;
  late bool _buttonDisabled;
  late TextEditingController offerController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    _buttonDisabled = false;
    offerController = TextEditingController();
    // If there is no userJob object, there will be no message, so we use an empty string
    offerController.text = widget.userJob?.message ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Description of the action that we are performing
    final _dialogAction = widget.userJob != null ? "Actualizar" : "Publicar";

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$_dialogAction Mensaje",
              style: Theme.of(context).textTheme.headline2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: offerController,
                keyboardType: TextInputType.multiline,
                // dynamic text lines
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mensaje',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(_dialogAction),
                    onPressed: _buttonDisabled
                        ? null
                        : () {
                            setState(() {
                              _buttonDisabled = true;
                              User user = controller.currentUser!;
                              UserSocial offer = UserSocial(
                                picUrl: user.photoURL ??
                                    "https://ui-avatars.com/api/?name=${user.displayName ?? 'User'}",
                                name: user.displayName!,
                                email: user.email!,
                                message: offerController.text,
                              );
                              Future task;
                              // If userJob is null, this means that this offer is new; otherwise,
                              // it means that we are updating a previous one.
                              if (widget.userJob != null) {
                                offer.dbRef = widget.userJob!.dbRef;
                                task = widget.manager.updatePublish(offer);
                              } else {
                                task = widget.manager.sendPublish(offer);
                              }
                              task.then(
                                (value) => Get.back(),
                              );
                            });
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    offerController.dispose();
    super.dispose();
  }
}
