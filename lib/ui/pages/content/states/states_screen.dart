import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/models/user_status.dart';
import 'package:misiontic_template/domain/use_case/controllers/connectivity.dart';
import 'package:misiontic_template/domain/use_case/status_management.dart';
import 'package:misiontic_template/ui/pages/content/states/widgets/new_state.dart';
import 'widgets/state_card.dart';

class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> {
  late final StatusManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream;
  late ConnectivityController controller;

  @override
  void initState() {
    super.initState();
    manager = StatusManager();
    statusesStream = manager.getStatusesStream();
    controller = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: MaterialButton(
              height: 60,
              minWidth: 150,
              color: Colors.pinkAccent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text("Agregar"),
              onPressed: () {
                // We don't allow to trigger the action if we don't have connectivity
                if (controller.connected) {
                  Get.dialog(
                    PublishDialog(
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
            stream: statusesStream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                final items = manager.extractStatuses(snapshot.data!);
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    UserStatus status = items[index];
                    return StateCard(
                      title: status.name,
                      content: status.message,
                      picUrl: status.picUrl,
                      onDelete: () {
                        manager.removeStatus(status);
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
