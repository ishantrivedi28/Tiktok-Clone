import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/view/widgets/glitch_effect.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(
              child: const Text(
                "TikTok Clone",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                myIcon: Icons.email,
                myLabelText: "Email",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                myIcon: Icons.lock,
                myLabelText: "Password",
                toHide: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthController.instance
                      .login(_emailController.text, _passwordController.text);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: const Text("Login"))),
            TextButton(
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                child: Text('New User? Sign Up'))
          ],
        ),
      ),
    );
  }
}
