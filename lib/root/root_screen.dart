// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/book_list/book_list_screen.dart';
//
// import 'package:untitled/login/login_screen.dart';
//
// class RootScreen extends StatelessWidget {
//   const RootScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         User? user = snapshot.data;
//         if (user == null) {
//           return const LoginScreen();
//         }
//         return BookListScreen();
//       },
//     );
//   }
// }