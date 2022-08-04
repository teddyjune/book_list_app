import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/update_book/update_book_view_model.dart';

class UpdateBookScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const UpdateBookScreen(this.document, {Key? key}) : super(key: key);

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();
  final viewModel = UpdateBookViewModel();

  @override
  void initState() {
    super.initState();
    _titleTextController.text = widget.document['title'];
    _authorTextController.text = widget.document['author'];
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _authorTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 추가'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '제목',
            ),
          ),
          TextField(
            controller: _authorTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '저자',
            ),
          ),
          ElevatedButton(onPressed: () {
            viewModel.updateBook(
              id: widget.document.id,
              title: _titleTextController.text,
              author: _authorTextController.text,
            );
            Navigator.pop(context);
          },
              child: Text('수정 버튼')),
        ],
      ),
    );
  }
}
