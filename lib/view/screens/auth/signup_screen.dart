import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/widgets/glitch_effect.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _setpasswordController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                child: const Text(
                  "Welcome to TikTok",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      await AuthController.instance.pickImage();
                      setState(() {});
                    },
                    child: AuthController.instance.proimg == null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg"),
                            radius: 60,
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                FileImage(AuthController.instance.proimg!),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        color: Colors.black,
                        Icons.edit,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
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
                  controller: _setpasswordController,
                  myIcon: Icons.lock,
                  myLabelText: "Set Password",
                  toHide: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _confirmpasswordController,
                  myIcon: Icons.lock,
                  myLabelText: "Confirm Password",
                  toHide: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _nameController,
                  myIcon: Icons.person,
                  myLabelText: "Username",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    AuthController.instance.SignUp(
                        _nameController.text,
                        _emailController.text,
                        _setpasswordController.text,
                        AuthController.instance.proimg);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: const Text("Sign Up")))
            ],
          ),
        ),
      ),
    );
  }
}
