import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_template/domain/use_case/controllers/authentication.dart';
import 'package:misiontic_template/domain/use_case/controllers/connectivity.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const LoginScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final connectivityController = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Iniciar sesión",
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
                  key: const Key("signInEmail"),
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
                  key: const Key("signInPassword"),
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0xFFF8BBD0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                      padding: const EdgeInsets.all(10.0),
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
                            await controller.manager.signIn(
                                email: emailController.text,
                                password: passwordController.text);
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
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              TextButton(
                key: const Key("toSignUpButton"),
                child: const Text(
                  "Aun no tienes cuenta?. Registrate!",
                  style: TextStyle(color: Color(0xFFF8BBD0)),
                ),
                onPressed: widget.onViewSwitch,
              ),
            ],
          ),
        ),
      ),
    );
  }

//  @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Iniciar sesión",
//               style: Theme.of(context).textTheme.headline1,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               key: const Key("signInEmail"),
//               controller: emailController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Correo electrónico',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               key: const Key("signInPassword"),
//               controller: passwordController,
//               obscureText: true,
//               obscuringCharacter: "*",
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Clave',
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: ElevatedButton(
//                     child: const Text("Login"),
//                     onPressed: () async {
//                       if (connectivityController.connected) {
//                         await controller.manager.signIn(
//                             email: emailController.text,
//                             password: passwordController.text);
//                       } else {
//                         Get.showSnackbar(
//                           GetBar(
//                             message: "No estas conectado a la red.",
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//           TextButton(
//             key: const Key("toSignUpButton"),
//             child: const Text("Registrarse"),
//             onPressed: widget.onViewSwitch,
//           ),
//         ],
//       ),
//     );
//   }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
