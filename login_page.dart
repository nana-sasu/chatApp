import 'package:flutter/material.dart';
import 'package:messageapp/services/auth/auth_service.dart';
import 'package:messageapp/components/my_button.dart';
import 'package:messageapp/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  //email & password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to go to the register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async {
    //auth services
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    }

    //catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
              "Welcome, You've been  missed",
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
              height: 25,
            ),

            // login button
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 25,
            ),

            //register now
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "No account?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " Register now",
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
