import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:untitled/book_list/book_list_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        User? user = snapshot.data;
        if (user == null) {
          return const SignInScreen(providerConfigs: [
            GoogleProviderConfiguration(
              clientId:
                  '245549996846-va5g89d9u0u9aptuftb6it7d18l36tur.apps.googleusercontent.com',
            ),
            EmailProviderConfiguration(),
          ]);
        }
        return BookListScreen();
      },
    );
  }
}
