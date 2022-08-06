import 'package:flutter/material.dart';
import 'package:untitled/login/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final viewModel = LoginViewModel();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('로그인'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이메일',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '패스워드',
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('신규 등록')),
            ElevatedButton(onPressed: () {
              viewModel.signInWithGoogle();
            }, child: const Text('Google 로그인')),
          ],
        ));
  }
}
