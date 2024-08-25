import 'package:flutter/material.dart';
import 'package:messageapp/services/auth/auth_service.dart';
import 'package:messageapp/components/my_button.dart';
import 'package:messageapp/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  //email & password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();

  //tap to go to the login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method
  void register(BuildContext context) {
    //get auth services
    final auth = AuthService();

    //if password match, Create user
    if (_pwController.text == _confirmpwController.text) {
      try {
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //if password dont match -> tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password dont match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 60.0,
                  color: Colors.grey.shade700,
                ),
                const Text(
                  " Safe",
                  style: TextStyle(
                      letterSpacing: 2.0, color: Colors.blue, fontSize: 20),
                ),
                const Text(
                  "Chat",
                  style: TextStyle(letterSpacing: 2.0, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),

            //welcome message
            const Text(
              "Let's create an account",
              style: TextStyle(fontSize: 16.0, letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 25,
            ),

            // email textfield
            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),

            //password textfield
            MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(
              height: 10,
            ),

            //confirm password
            MyTextfield(
              hintText: " Confirm password",
              obscureText: true,
              controller: _confirmpwController,
            ),
            const SizedBox(
              height: 25,
            ),

            // login button
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),

            //register now
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Already has an account?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
