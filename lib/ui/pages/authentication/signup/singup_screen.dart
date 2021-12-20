import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/data/services/database.dart';
import 'package:misiontic_template/domain/use_case/controllers/authentication.dart';
import 'package:misiontic_template/domain/use_case/controllers/connectivity.dart';
import 'package:misiontic_template/helper/helpperfunctions.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const SignUpScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final connectivityController = Get.find<ConnectivityController>();
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Creación de usuario",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              // style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signUpName"),
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFFF8BBD0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                labelStyle: TextStyle(color: Color(0xFFF8BBD0)),
                labelText: 'Usuario',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signUpEmail"),
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.mail,
                  color: Color(0xFFF8BBD0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                labelStyle: TextStyle(color: Color(0xFFF8BBD0)),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signUpPassword"),
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Color(0xFFF8BBD0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                labelStyle: TextStyle(color: Color(0xFFF8BBD0)),
                labelText: 'Clave',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MaterialButton(
                    height: 60,
                    minWidth: double.infinity,
                    color: Colors.pinkAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      if (connectivityController.connected) {
                        await controller.manager.signUp(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                        Map<String, String> userInfoMap = {
                          "name": nameController.text,
                          "email": emailController.text,
                        };
                        HelperFunctions.saveUserEmailSharedPreference(
                            emailController.text);
                        HelperFunctions.saveUserNameSharedPreference(
                            nameController.text);

                        databaseMethods.addUserInfo(userInfoMap);
                        HelperFunctions.saveUserLoggedInSharedPreference(true);
                      } else {
                        Get.showSnackbar(
                          GetBar(
                            message: "No estas conectado a la red.",
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Registrar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: widget.onViewSwitch,
            child: const Text(
              "Entrar",
              style: TextStyle(color: Color(0xFFF8BBD0)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
