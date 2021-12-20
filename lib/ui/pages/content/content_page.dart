import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/use_case/controllers/authentication.dart';
import 'package:misiontic_template/domain/use_case/controllers/ui.dart';
import 'package:misiontic_template/ui/pages/chat/chatRoomsScreen.dart';
import 'package:misiontic_template/ui/pages/chat/chat_page.dart';
import 'package:misiontic_template/ui/pages/chat/messages/chatrooms.dart';
import 'package:misiontic_template/ui/pages/content/chats/chat_screen.dart';
import 'package:misiontic_template/ui/pages/content/location/location_screen.dart';

import 'package:misiontic_template/ui/pages/content/public_product/widgets/product_screen.dart';

import 'package:misiontic_template/ui/pages/content/states/states_screen.dart';

import 'package:misiontic_template/ui/pages/content/users_social/users_social_screen.dart';
import 'package:misiontic_template/ui/widgets/appbar.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

// View content
  Widget _getScreen(int index) {
    switch (index) {
      case 1:
        return const UsersSocialScreen();
      case 2:
        return ProductScreen();
      case 3:
        return LocationScreen();
      case 4:
        return  ChatRoom();
      default:
        return const StatesScreen();
    }
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    // Dependency injection: State management controller
    final UIController controller = Get.find<UIController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        controller: controller,
        picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
        tile: const Text("Red de Maquillajes"),
        onSignOff: () {
          authController.manager.signOut();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Obx(() => _getScreen(controller.reactiveScreenIndex.value)),
          ),
        ),
      ),
      // Content screen navbar
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.lightbulb_outline_rounded,
                  key: Key("statesSection"),
                ),
                label: 'Estados',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group_outlined,
                  key: Key("socialSection"),
                ),
                label: 'Social',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.public_outlined,
                  key: Key("offersSection"),
                ),
                label: 'Producto',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.place_outlined,
                  key: Key("locationSection"),
                ),
                label: 'Ubicación',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_outline,
                ),
                label: 'Mensajes',
              ),
            ],
            currentIndex: controller.screenIndex,
            onTap: (index) {
              controller.screenIndex = index;
            },
          )),
    );
  }
}
