import 'package:flutter/material.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('도서 리스트'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('flutter 생존코딩'),
            subtitle: Text('오준석'),
          ),
          ListTile(
            title: Text('flutter 생존코딩'),
            subtitle: Text('오준석'),
          ),
          ListTile(
            title: Text('flutter 생존코딩'),
            subtitle: Text('오준석'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
      ),
    );
  }
}
